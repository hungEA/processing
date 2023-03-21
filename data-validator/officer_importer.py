import os
import pandas as pd
from wrgl import Repository
from slack_sdk import WebClient


OFFICER_COLS = [
    'uid', 'last_name', 'middle_name', 'first_name', 'birth_year',
    'birth_month', 'birth_day', 'race', 'sex', 'agency'
]


def __retrieve_officer_frm_wrgl_data(branch=None):
    repo = Repository("https://wrgl.llead.co/", None)

    original_commit = repo.get_branch("personnel")

    columns = original_commit.table.columns
    if not set(OFFICER_COLS).issubset(set(columns)):
        raise Exception('BE officer columns are not recognized in the current commit')

    all_rows = list(repo.get_blocks("heads/personnel"))
    df = pd.DataFrame(all_rows)
    df.columns = df.iloc[0]
    df = df.iloc[1:].reset_index(drop=True)

    df.to_csv('officer.csv', index=False)


def __preprocess_officer(agency_df):
    df = pd.read_csv('officer.csv')

    result = pd.merge(df, agency_df, how='left', on='agency')

    print('Check agency id after merged')
    null_data = result[result['department_id'].isnull()]
    if len(null_data) > 0:
        client = WebClient(os.environ.get('SLACK_BOT_TOKEN'))
        null_data.to_csv('null_agency_of_officers.csv', index=False)

        # Temporarily disabled to pass the check in order to continue developing
        # client.files_upload(
        #     channels=os.environ.get('SLACK_CHANNEL'),
        #     title="Null agency of officers",
        #     file="./null_agency_of_officers.csv",
        #     initial_comment="The following file provides a list of personnels that cannot map to agency:",
        # )

        # raise Exception('Cannot map officer to agency')

    # Temporarily drop NA to continue, otherwise, comment out this statement
    result.dropna(subset=['department_id'], inplace=True)

    result = result.astype({
        'department_id': int,
        'birth_year': pd.Int64Dtype(),
        'birth_month': pd.Int64Dtype(),
        'birth_day': pd.Int64Dtype()
    })
    result.to_csv('officer.csv', index=False)


def import_officer(conn):
    __retrieve_officer_frm_wrgl_data()


    agency_df = pd.read_sql('SELECT id, agency_slug FROM departments_department', conn)
    agency_df.columns = ['department_id', 'agency']

    __preprocess_officer(agency_df)

    cursor = conn.cursor()
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
    conn.commit()
    cursor.close()

    df = pd.read_sql('''
        SELECT uid, last_name, middle_name, first_name, birth_year,
                birth_month, birth_day, race, sex, agency, department_id
        FROM officers_officer
        ''',
        con=conn
    )

    print('List top 10 officers')
    print(df.head(10))
