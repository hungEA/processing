import os
import pandas as pd
# from tqdm import tqdm
from wrgl import Repository
from slack_sdk import WebClient


COMPLAINT_COLS = {
    'uid', 'tracking_id', 'allegation_uid', 'allegation',
    'disposition', 'action', 'agency', 'allegation_desc'
}


def __retrieve_complaint_frm_wrgl_data():
    repo = Repository("https://wrgl.llead.co/", None)

    # new_commit = repo.get_branch("agency-reference-list")

    # original_commit = repo.get_commit("9e82d17d64a7950c731031a3e8124815")
    original_commit = repo.get_branch("allegation")

    columns = original_commit.table.columns
    if not COMPLAINT_COLS.issubset(set(columns)):
        raise Exception('BE complaint columns are not recognized in the current commit')

    # result = repo.diff(original_commit, None)
    # result = repo.get_blocks('a6ef318b18113d2661ff966fdf4972f0')

    # added_rows = []
    # with tqdm(
    #     total=len(result), desc="Downloading created data"
    # ) as pbar:
    #     for i in range(0, len(result), 1000):
    #         added_rows.extend(
    #             list(
    #                 repo.get_table_rows(
    #                     original_commit.table.sum,
    #                     result[i : i + 1000],
    #                 )
    #             )
    #         )
    #         pbar.update(1000)

    # df = pd.DataFrame(added_rows)
    all_rows = list(repo.get_blocks("heads/allegation"))
    df = pd.DataFrame(all_rows)
    df.columns = df.iloc[0]
    df = df.iloc[1:].reset_index(drop=True)

    df = df.loc[:, COMPLAINT_COLS]
    df.to_csv('complaint.csv', index=False)


def __build_complaints_officers_rel(conn):

    complaints_df = pd.read_sql(
        'SELECT id, allegation_uid, uid FROM complaints_complaint',
        con=conn
    )
    complaints_df.columns = ['complaint_id', 'allegation_uid', 'uid']

    officers_df = pd.read_sql(
        'SELECT id, uid FROM officers_officer',
        con=conn
    )
    officers_df.columns = ['officer_id, uid']

    result = pd.merge(complaints_df, officers_df, how='left', on='uid')

    print('Check officer id after merged')
    null_data = result[result['officer_id'].isnull()]
    if len(null_data) > 0:
        client = WebClient(os.environ.get('SLACK_BOT_TOKEN'))
        null_data.to_csv('null_officer_of_complaint.csv', index=False)

        # client.files_upload(
        #     channels=os.environ.get('SLACK_CHANNEL'),
        #     title="Null agency of officers",
        #     file="./null_agency_of_officers.csv",
        #     initial_comment="The following file provides a list of personnels that cannot map to agency:",
        # )

        raise Exception('Cannot map officer to agency')

    result = result.loc[:, ["complaint_id", "officer_id"]]
    result.to_csv('complaints_officers_rel.csv', index=False)


def import_complaint(conn):
    __retrieve_complaint_frm_wrgl_data()

    complaint_df = pd.read_csv('complaint.csv')
    print(complaint_df.columns)

    cursor = conn.cursor()
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
    conn.commit()
    cursor.close()

    __build_complaints_officers_rel(conn)

    cursor = conn.cursor()
    cursor.copy_expert(
        sql="""
            COPY complaints_complaint_officers(
                'complaint_id', 'officer_id'
            ) FROM stdin WITH CSV HEADER
            DELIMITER as ','
        """,
        file=open('complaints_officers_rel.csv', 'r'),
    )
    conn.commit()
    cursor.close()

    cursor = conn.cursor()
    count = cursor.execute('SELECT COUNT(*) FROM complaints_complaint_officers')
    print('Number of records in complaints_officers rel', count.iloc[0])
