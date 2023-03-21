import os
import pandas as pd
from wrgl import Repository
from slack_sdk import WebClient


CITIZEN_COLS = [
    'citizen_uid', 'allegation_uid', 'uof_uid', 'citizen_influencing_factors',
    'citizen_arrested', 'citizen_hospitalized', 'citizen_injured', 'citizen_age',
    'citizen_race', 'citizen_sex', 'agency'
]


def __retrieve_citizen_frm_wrgl_data(branch=None):
    repo = Repository("https://wrgl.llead.co/", None)

    original_commit = repo.get_branch("citizens")

    columns = original_commit.table.columns
    if not set(CITIZEN_COLS).issubset(set(columns)):
        raise Exception('BE citizens columns are not recognized in the current commit')

    all_rows = list(repo.get_blocks("heads/citizens"))
    df = pd.DataFrame(all_rows)
    df.columns = df.iloc[0]
    df = df.iloc[1:].reset_index(drop=True)

    df.to_csv('citizens.csv', index=False)


def __build_citizen_rel(conn):
    print('Building relationship between agency and citizens')
    citizen_df = pd.read_csv('citizens.csv')

    agency_df = pd.read_sql(
        'SELECT id, agency_slug FROM departments_department',
        con=conn
    )
    agency_df.columns = ['department_id', 'agency']

    result = pd.merge(citizen_df, agency_df, how='left', on='agency')

    print('Check agency id after merged')
    null_department_data = result[result['department_id'].isnull()]
    if len(null_department_data) > 0:
        # client = WebClient(os.environ.get('SLACK_BOT_TOKEN'))
        # null_data.to_csv('null_agency_of_citizen.csv', index=False)

        # # Temporarily disabled to pass the check in order to continue developing
        # client.files_upload(
        #     channels=os.environ.get('SLACK_CHANNEL'),
        #     title="Null agency of citizen",
        #     file="./null_agency_of_citizen.csv",
        #     initial_comment="The following file provides a list of agency that cannot map to citizen:",
        raise Exception('Cannot map agency to citizen')

    print('Build relationship between complaints and citizens')
    complaints_df = pd.read_sql(
        'SELECT id, allegation_uid FROM complaints_complaint',
        con=conn
    )
    complaints_df.columns = ['complaint_id', 'allegation_uid']

    result = pd.merge(result, complaints_df, how='left', on='allegation_uid')

    print('Build relationship between uof and citizens')
    uof_df = pd.read_sql(
        'SELECT id, uof_uid FROM use_of_forces_useofforce',
        con=conn
    )
    uof_df.columns = ['uof_id', 'uof_uid']

    result = pd.merge(result, uof_df, how='left', on='uof_uid')

    result = result.loc[:, CITIZEN_COLS + ['department_id', 'complaint_id', 'uof_id']]
    result = result.astype({
        'department_id': int,
        'complaint_id': pd.Int64Dtype(),
        'uof_id': pd.Int64Dtype(),
        'citizen_age': pd.Int64Dtype()
    })
    result.to_csv('citizens.csv', index=False)


def import_citizen(conn):
    __retrieve_citizen_frm_wrgl_data()
    __build_citizen_rel(conn)

    cursor = conn.cursor()
    cursor.copy_expert(
        sql="""
            COPY citizens_citizen(
                citizen_uid, allegation_uid, uof_uid, citizen_influencing_factors,
                citizen_arrested, citizen_hospitalized, citizen_injured, citizen_age,
                citizen_race, citizen_sex, agency, department_id, complaint_id, use_of_force_id
            ) FROM stdin WITH CSV HEADER
            DELIMITER as ','
        """,
        file=open('citizens.csv', 'r'),
    )
    conn.commit()
    cursor.close()

    df = pd.read_sql('''
        SELECT citizen_uid, allegation_uid, uof_uid,
            agency, department_id, complaint_id, use_of_force_id
        FROM citizens_citizen
        ''',
        con=conn
    )

    print('List top 10 citizen')
    print(df.head(10))
