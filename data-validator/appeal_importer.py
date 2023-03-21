import os
import pandas as pd
from wrgl import Repository
from slack_sdk import WebClient


APPEAL_COLS = [
    'appeal_uid', 'uid', 'charging_supervisor', 'appeal_disposition',
    'action_appealed', 'agency', 'motions'
]


def __retrieve_appeal_frm_wrgl_data(branch=None):
    repo = Repository("https://wrgl.llead.co/", None)

    original_commit = repo.get_branch("appeal-hearing")

    columns = original_commit.table.columns
    if not set(APPEAL_COLS).issubset(set(columns)):
        raise Exception('BE appeal columns are not recognized in the current commit')

    all_rows = list(repo.get_blocks("heads/appeal-hearing"))
    df = pd.DataFrame(all_rows)
    df.columns = df.iloc[0]
    df = df.iloc[1:].reset_index(drop=True)

    df.to_csv('appeals.csv', index=False)


def __build_appeal_rel(conn):
    print('Check integrity between officers\' agency and appeal agency')
    appeals_df = pd.read_csv('appeals.csv')

    officers_df = pd.read_sql(
        'SELECT id, uid, agency FROM officers_officer',
        con=conn
    )
    officers_df.columns = ['officer_id', 'uid', 'officer_agency_slug']

    aor_df = pd.merge(appeals_df, officers_df, how='left', on='uid')

    print('Check officer id after merged')
    null_officers_data = aor_df[aor_df['officer_id'].isnull()]
    if len(null_officers_data) > 0:
        client = WebClient(os.environ.get('SLACK_BOT_TOKEN'))
        null_officers_data.to_csv('null_officers_of_complaints.csv', index=False)

        # Temporarily disabled to pass the check in order to continue developing
        # client.files_upload(
        #     channels=os.environ.get('SLACK_CHANNEL'),
        #     title="Null officers of appeals",
        #     file="./null_officers_of_appeals.csv",
        #     initial_comment="The following file provides a list of personnels that cannot map to appeal:",
        # )

        raise Exception('Cannot map officer to appeal')

    aor_df['agency_slug'] = aor_df.apply(
        lambda x: x['officer_agency_slug'] if pd.isnull(x['agency']) \
                    else x['agency'],
        axis=1
    )

    print('Check agency discrepancy')
    diff_agency_data = aor_df[aor_df['officer_agency_slug'] != aor_df['agency_slug']]
    if len(diff_agency_data) > 0:
        raise Exception('There are discrepancy between officer agency and appeal agency')

    agency_df = pd.read_sql(
        'SELECT id, agency_slug FROM departments_department',
        con=conn
    )
    agency_df.columns = ['department_id', 'agency_slug']

    result = pd.merge(aor_df, agency_df, how='left', on='agency_slug')

    print('Check agency id after merged')
    null_department_data = result[result['department_id'].isnull()]
    if len(null_department_data) > 0:
        # client = WebClient(os.environ.get('SLACK_BOT_TOKEN'))
        # null_data.to_csv('null_agency_of_complaints.csv', index=False)

        # # Temporarily disabled to pass the check in order to continue developing
        # client.files_upload(
        #     channels=os.environ.get('SLACK_CHANNEL'),
        #     title="Null agency of appeals",
        #     file="./null_agency_of_appeals.csv",
        #     initial_comment="The following file provides a list of agency that cannot map to appeal:",
        raise Exception('Cannot map agency to appeal')

    final_result = result.loc[:, APPEAL_COLS + ['officer_id', 'department_id']]
    final_result.to_csv('appeals.csv', index=False)


def import_appeal(conn):
    __retrieve_appeal_frm_wrgl_data()
    __build_appeal_rel(conn)

    cursor = conn.cursor()
    cursor.copy_expert(
        sql="""
            COPY appeals_appeal(
                appeal_uid, uid, charging_supervisor, appeal_disposition,
                action_appealed, agency, motions, officer_id, department_id
            ) FROM stdin WITH CSV HEADER
            DELIMITER as ','
        """,
        file=open('appeals.csv', 'r'),
    )
    conn.commit()
    cursor.close()

    df = pd.read_sql('''
        SELECT appeal_uid, uid, charging_supervisor, appeal_disposition,
            action_appealed, agency, motions, officer_id, department_id
        FROM appeals_appeal
        ''',
        con=conn
    )

    print('List top 10 appeal')
    print(df.head(10))
