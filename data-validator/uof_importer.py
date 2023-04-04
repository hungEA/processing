import os
import pandas as pd
from slack_sdk import WebClient
# from wrgl import Repository


UOF_COLS = [
    'uid', 'uof_uid', 'tracking_id', 'service_type', 'disposition',
    'use_of_force_description', 'officer_injured', 'agency', 'use_of_force_reason'
]


# def __retrieve_uof_frm_wrgl_data(branch=None):
#     repo = Repository("https://wrgl.llead.co/", None)

#     original_commit = repo.get_branch("use-of-force")

#     columns = original_commit.table.columns
#     if not set(UOF_COLS).issubset(set(columns)):
#         raise Exception('BE use-of-force columns are not recognized in the current commit')

#     all_rows = list(repo.get_blocks("heads/use-of-force"))
#     df = pd.DataFrame(all_rows)
#     df.columns = df.iloc[0]
#     df = df.iloc[1:].reset_index(drop=True)

#     df.to_csv('uof.csv', index=False)


def __build_uof_rel(db_con):
    client = WebClient(os.environ.get('SLACK_BOT_TOKEN'))

    print('Check integrity between officers\' agency and uof agency')
    uof_df = pd.read_csv(
        os.path.join(os.environ.get('DATA_DIR'), 'use_of_force.csv')
    )

    officers_df = pd.read_sql(
        'SELECT id, uid, agency FROM officers_officer',
        con=db_con
    )
    officers_df.columns = ['officer_id', 'uid', 'officer_agency_slug']

    uofor_df = pd.merge(uof_df, officers_df, how='left', on='uid')

    print('Check officer id after merged')
    null_officers_data = uofor_df[uofor_df['officer_id'].isnull()]
    if len(null_officers_data) > 0:
        null_officers_data.to_csv('null_officers_of_uof.csv', index=False)

        client.files_upload(
            channels=os.environ.get('SLACK_CHANNEL'),
            title="Null officers of uof",
            file="./null_officers_of_uof.csv",
            initial_comment="The following file provides a list of personnels that cannot map to uof:",
        )

        raise Exception('Cannot map officer to uof')

    uofor_df['agency_slug'] = uofor_df.apply(
        lambda x: x['officer_agency_slug'] if pd.isnull(x['agency']) \
                    else x['agency'],
        axis=1
    )

    print('Check agency discrepancy')
    diff_agency_data = uofor_df[uofor_df['officer_agency_slug'] != uofor_df['agency_slug']]
    if len(diff_agency_data) > 0:
        raise Exception('There are discrepancy between officer agency and uof agency')

    agency_df = pd.read_sql(
        'SELECT id, agency_slug FROM departments_department',
        con=db_con
    )
    agency_df.columns = ['department_id', 'agency_slug']

    result = pd.merge(uofor_df, agency_df, how='left', on='agency_slug')

    print('Check agency id after merged')
    null_department_data = result[result['department_id'].isnull()]
    if len(null_department_data) > 0:
        null_department_data.to_csv('null_agency_of_uof.csv', index=False)

        client.files_upload(
            channels=os.environ.get('SLACK_CHANNEL'),
            title="Null agency of uof",
            file="./null_agency_of_uof.csv",
            initial_comment="The following file provides a list of agency that cannot map to uof:",
        )

        raise Exception('Cannot map agency to uof')

    result = result.loc[:, UOF_COLS + ['officer_id', 'department_id']]
    result.to_csv('uof.csv', index=False)


def import_uof(db_con):
    __build_uof_rel(db_con)

    cursor = db_con.cursor()
    cursor.copy_expert(
        sql="""
            COPY use_of_forces_useofforce(
                uid, uof_uid, tracking_id, service_type, disposition,
                use_of_force_description, officer_injured, agency, use_of_force_reason,
                officer_id, department_id
            ) FROM stdin WITH CSV HEADER
            DELIMITER as ','
        """,
        file=open('uof.csv', 'r'),
    )
    db_con.commit()
    cursor.close()

    count = pd.read_sql(
        'SELECT COUNT(*) FROM use_of_forces_useofforce',
        con=db_con
    )
    print('Number of records in useofforce', count.iloc[0][0])
