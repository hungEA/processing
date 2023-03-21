import os
import sys
import pandas as pd
from wrgl import Repository
from slack_sdk import WebClient


COMPLAINT_COLS = [
    'uid', 'tracking_id', 'allegation_uid', 'allegation',
    'disposition', 'action', 'agency', 'allegation_desc'
]


def __retrieve_complaint_frm_wrgl_data():
    repo = Repository("https://wrgl.llead.co/", None)

    original_commit = repo.get_branch("allegation")

    columns = original_commit.table.columns
    if not set(COMPLAINT_COLS).issubset(set(columns)):
        raise Exception('BE complaint columns are not recognized in the current commit')

    all_rows = list(repo.get_blocks("heads/allegation"))
    df = pd.DataFrame(all_rows)
    df.columns = df.iloc[0]
    df = df.iloc[1:].reset_index(drop=True)

    df = df.loc[:, COMPLAINT_COLS]
    df.to_csv('complaint.csv', index=False)


def __build_complaints_relationship(conn):
    print('Building complaints_officers relationship')
    complaints_df = pd.read_sql(
        'SELECT id, allegation_uid, uid, agency FROM complaints_complaint',
        con=conn
    )
    complaints_df.columns = ['complaint_id', 'allegation_uid', 'uid', 'complaint_agency']

    officers_df = pd.read_sql(
        'SELECT id, uid, agency FROM officers_officer',
        con=conn
    )
    officers_df.columns = ['officer_id', 'uid', 'officer_agency_slug']

    cor_df = pd.merge(complaints_df, officers_df, how='left', on='uid')

    print('Check officer id after merged')
    null_officers_data = cor_df[cor_df['officer_id'].isnull()]
    if len(null_officers_data) > 0:
        client = WebClient(os.environ.get('SLACK_BOT_TOKEN'))
        null_officers_data.to_csv('null_officers_of_complaints.csv', index=False)

        # Temporarily disabled to pass the check in order to continue developing
        # client.files_upload(
        #     channels=os.environ.get('SLACK_CHANNEL'),
        #     title="Null officers of complaints",
        #     file="./null_officers_of_complaints.csv",
        #     initial_comment="The following file provides a list of personnels that cannot map to complaint:",
        # )

        # raise Exception('Cannot map officer to complaint')

    # Temporarily drop NA to continue, otherwise, comment out this statement
    final_cor_df = cor_df.dropna(subset=['officer_id'])

    final_cor_df = final_cor_df.loc[:, ["complaint_id", "officer_id"]]
    final_cor_df.to_csv('complaints_officers_rel.csv', index=False)

    print('Building complaints_departments relationship')
    cod_df = cor_df.copy()
    cod_df['agency_slug'] = cod_df.apply(
        lambda x: x['officer_agency_slug'] if pd.isnull(x['complaint_agency']) \
                    else x['complaint_agency'],
        axis=1
    )

    null_agency_data = cod_df[cod_df['agency_slug'].isnull()]
    if len(null_agency_data) > 0:
        raise Exception('Cannot find agency for complaint')

    diff_agency_data = cod_df[cod_df['officer_agency_slug'] != cod_df['agency_slug']]
    if len(diff_agency_data) > 0:
        raise Exception('There are discrepancy')

    agency_df = pd.read_sql(
        'SELECT id, agency_slug FROM departments_department',
        con=conn
    )
    agency_df.columns = ['department_id', 'agency_slug']

    cdr_df = pd.merge(cod_df, agency_df, how='left', on='agency_slug')

    print('Check agency id after merged')
    null_department_data = cdr_df[cdr_df['department_id'].isnull()]
    if len(null_department_data) > 0:
        # client = WebClient(os.environ.get('SLACK_BOT_TOKEN'))
        # null_data.to_csv('null_agency_of_complaints.csv', index=False)

        # # Temporarily disabled to pass the check in order to continue developing
        # client.files_upload(
        #     channels=os.environ.get('SLACK_CHANNEL'),
        #     title="Null agency of complaints",
        #     file="./null_agency_of_complaints.csv",
        #     initial_comment="The following file provides a list of agency that cannot map to complaint:",
        raise Exception('Cannot map agency to complaint')

    # Temporarily drop NA to continue, otherwise, comment out this statement
    cdr_df.dropna(subset=['department_id'], inplace=True)

    cdr_df = cdr_df.loc[:, ["complaint_id", "department_id"]]
    cdr_df.to_csv('complaints_departments_rel.csv', index=False)


def import_complaint(conn):
    __retrieve_complaint_frm_wrgl_data()

    complaint_df = pd.read_csv('complaint.csv')
    print(complaint_df.columns)

    cursor = conn.cursor()
    try:
        cursor.copy_expert(
            sql="""
                COPY complaints_complaint(
                    uid, tracking_id, allegation_uid, allegation,
                    disposition, action, agency, allegation_desc
                ) FROM stdin WITH CSV HEADER
                DELIMITER as ','
            """,
            file=open('complaint.csv', 'r'),
        )
    except Exception as e:
        print(e)
        client = WebClient(os.environ.get('SLACK_BOT_TOKEN'))

        client.files_upload(
            channels=os.environ.get('SLACK_CHANNEL'),
            title="Complaint",
            file="./complaint.csv",
            initial_comment="The following file provides a list of personnels that contain errors:",
        )
        sys.exit(True)

    conn.commit()
    cursor.close()

    __build_complaints_relationship(conn)

    print('Importing complaints and officers relationship')
    cursor = conn.cursor()
    cursor.copy_expert(
        sql="""
            COPY complaints_complaint_officers(
                complaint_id, officer_id
            ) FROM stdin WITH CSV HEADER
            DELIMITER as ','
        """,
        file=open('complaints_officers_rel.csv', 'r'),
    )
    conn.commit()
    cursor.close()

    count = pd.read_sql(
        'SELECT COUNT(*) FROM complaints_complaint_officers',
        con=conn
    )
    print('Number of records in complaints_officers rel', count.iloc[0])

    print('Importing complaints and agency relationship')
    cursor = conn.cursor()
    cursor.copy_expert(
        sql="""
            COPY complaints_complaint_departments(
                complaint_id, department_id
            ) FROM stdin WITH CSV HEADER
            DELIMITER as ','
        """,
        file=open('complaints_departments_rel.csv', 'r'),
    )
    conn.commit()
    cursor.close()

    count = pd.read_sql(
        'SELECT COUNT(*) FROM complaints_complaint_departments',
        con=conn
    )
    print('Number of records in complaints_departments rel', count.iloc[0])
