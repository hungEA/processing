import os
import pandas as pd
from slack_sdk import WebClient
# from wrgl import Repository


OFFICER_COLS = [
    'uid', 'last_name', 'middle_name', 'first_name', 'birth_year',
    'birth_month', 'birth_day', 'race', 'sex', 'agency'
]


# def __retrieve_officer_frm_wrgl_data(branch=None):
#     repo = Repository("https://wrgl.llead.co/", None)

#     original_commit = repo.get_branch("personnel")

#     columns = original_commit.table.columns
#     if not set(OFFICER_COLS).issubset(set(columns)):
#         raise Exception('BE officer columns are not recognized in the current commit')

#     all_rows = list(repo.get_blocks("heads/personnel"))
#     df = pd.DataFrame(all_rows)
#     df.columns = df.iloc[0]
#     df = df.iloc[1:].reset_index(drop=True)

#     df.to_csv('officer.csv', index=False)


def __preprocess_officer(agency_df):
    client = WebClient(os.environ.get('SLACK_BOT_TOKEN'))
    officer_df = pd.read_csv(os.path.join(os.environ.get('DATA_DIR'), 'personnel.csv'))

    result = pd.merge(officer_df, agency_df, how='left', on='agency')

    print('Check agency id after merged')
    null_data = result[result['department_id'].isnull()]
    if len(null_data) > 0:
        null_data.drop_duplicates(subset=['agency'], inplace=True)
        null_data.to_csv(
            'null_agency_of_officers.csv',
            columns=['agency'],
            index=False,
            header=False
        )

        client.files_upload(
            channels=os.environ.get('SLACK_CHANNEL'),
            title="Null agency of officers",
            file="./null_agency_of_officers.csv",
            initial_comment="The following file provides a list of agency in personnels that cannot map to departments:",
        )

        raise Exception('Cannot map officer to agency')

    result = result.astype({
        'department_id': int,
        'birth_year': pd.Int64Dtype(),
        'birth_month': pd.Int64Dtype(),
        'birth_day': pd.Int64Dtype()
    })
    result.to_csv('officer.csv', index=False)


def import_officer(db_con):
    agency_df = pd.read_sql('SELECT id, agency_slug FROM departments_department', db_con)
    agency_df.columns = ['department_id', 'agency']

    __preprocess_officer(agency_df)

    cursor = db_con.cursor()
    cursor.copy_expert(
        sql="""
            COPY officers_officer(
                uid, last_name, middle_name, first_name, birth_year,
                birth_month, birth_day, race, sex, agency, department_id
            ) FROM stdin WITH CSV HEADER
            DELIMITER as ','
        """,
        file=open('officer.csv', 'r'),
    )
    db_con.commit()
    cursor.close()

    df = pd.read_sql('''
        SELECT uid, last_name, middle_name, first_name, birth_year,
                birth_month, birth_day, race, sex, agency, department_id
        FROM officers_officer
        ''',
        con=db_con
    )

    print('List top 10 officers')
    print(df.head(10))
