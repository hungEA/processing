import os
import pandas as pd
from slack_sdk import WebClient
from wrgl import Repository


# According to this post https://eastagile.slack.com/archives/C044F7LTASV/p1680028339523139?thread_ts=1679905963.191559&cid=C044F7LTASV
# documents are not saved to fuse folder or going through the same process
# of https://github.com/ipno-llead/processing
# Therefore we need to retrieve it from WRGL

def __retrieve_document_frm_wrgl_data(documents_cols):
    repo = Repository("https://wrgl.llead.co/", None)

    original_commit = repo.get_branch("documents")

    columns = original_commit.table.columns
    if not set(documents_cols).issubset(set(columns)):
        raise Exception('BE documents columns are not recognized in the current commit')

    all_rows = list(repo.get_blocks("heads/documents"))
    df = pd.DataFrame(all_rows)
    df.columns = df.iloc[0]
    df = df.iloc[1:].reset_index(drop=True)

    df = df.loc[:, documents_cols]
    df.to_csv('documents.csv', index=False)


def __build_document_rel(db_con):
    client = WebClient(os.environ.get('SLACK_BOT_TOKEN'))

    print('Building documents_officers relationship')
    documents_df = pd.read_sql(
        'SELECT id, docid, matched_uid, agency FROM documents_document',
        con=db_con
    )
    documents_df.columns = ['document_id', 'docid', 'uid', 'agency_slug']

    officers_df = pd.read_sql(
        'SELECT id, uid FROM officers_officer',
        con=db_con
    )
    officers_df.columns = ['officer_id', 'uid']

    dor_df = pd.merge(documents_df, officers_df, how='left', on='uid')

    no_officers_in_documents = documents_df['uid'].dropna().unique()
    print('Number of officers in WRGL documents', len(no_officers_in_documents))
    diff_officers = set(no_officers_in_documents) - set(officers_df['uid'])
    print('Number of differences in officers', len(diff_officers))

    if len(diff_officers) > 0:
        with open('diff_officers_of_documents.csv', 'w') as fwriter:
            fwriter.write('\n'.join(list(diff_officers)))

        client.files_upload(
            channels=os.environ.get('SLACK_CHANNEL'),
            title="Diff of officers of documents",
            file="./diff_officers_of_documents.csv",
            initial_comment="The following file provides a list of matched_uid in documents that cannot map to officers:",
        )

        raise Exception('There is anomaly in the number of officers in documents')

    dor_df.dropna(subset=['officer_id'], inplace=True)

    dor_df = dor_df.loc[:, ['document_id', 'officer_id']]
    dor_df = dor_df.astype({
        'document_id': int,
        'officer_id': pd.Int64Dtype(),
    })
    dor_df.to_csv('documents_officers_rel.csv', index=False)

    print('Building documents_agency relationship')
    agency_df = pd.read_sql(
        'SELECT id, agency_slug FROM departments_department',
        con=db_con
    )
    agency_df.columns = ['department_id', 'agency_slug']

    ddr_df = pd.merge(documents_df, agency_df, how='left', on='agency_slug')

    no_agency_in_documents = documents_df['agency_slug'].dropna().unique()
    print('Number of agency in WRGL documents', len(no_agency_in_documents))
    diff_agency = set(no_agency_in_documents) - set(agency_df['agency_slug'])
    print('Number of differences in agency', len(diff_agency))

    if len(diff_agency) > 0:
        with open('diff_agency_of_documents.csv', 'w') as fwriter:
            fwriter.write('\n'.join(list(diff_agency)))

        client.files_upload(
            channels=os.environ.get('SLACK_CHANNEL'),
            title="Diff of agency of documents",
            file="./diff_agency_of_documents.csv",
            initial_comment="The following file provides a list of agency in documents that cannot map to department:",
        )

        raise Exception('There is anomaly in the number of agency in documents')

    ddr_df.dropna(subset=['department_id'], inplace=True)

    ddr_df = ddr_df.loc[:, ['document_id', 'department_id']]
    ddr_df = ddr_df.astype({
        'document_id': int,
        'department_id': pd.Int64Dtype(),
    })
    ddr_df.to_csv('documents_departments_rel.csv', index=False)


def run(db_con, documents_df, documents_cols):
    __retrieve_document_frm_wrgl_data(documents_cols)

    cursor = db_con.cursor()
    cursor.copy_expert(
        sql=f"""
            COPY documents_document({', '.join(documents_cols)})
            FROM stdin WITH CSV HEADER
            DELIMITER as ','
        """,
        file=open('documents.csv', 'r'),
    )
    db_con.commit()
    cursor.close()

    __build_document_rel(db_con)

    # Importing documents and officers relationship
    cursor = db_con.cursor()
    cursor.copy_expert(
        sql="""
            COPY documents_document_officers(
                document_id, officer_id
            ) FROM stdin WITH CSV HEADER
            DELIMITER as ','
        """,
        file=open('documents_officers_rel.csv', 'r'),
    )
    db_con.commit()
    cursor.close()

    count = pd.read_sql(
        'SELECT COUNT(*) FROM documents_document_officers',
        con=db_con
    )
    print('Number of records in documents_officers rel', count.iloc[0][0])

    # Importing documents and agency relationship
    cursor = db_con.cursor()
    cursor.copy_expert(
        sql="""
            COPY documents_document_departments(
                document_id, department_id
            ) FROM stdin WITH CSV HEADER
            DELIMITER as ','
        """,
        file=open('documents_departments_rel.csv', 'r'),
    )
    db_con.commit()
    cursor.close()

    count = pd.read_sql(
        'SELECT COUNT(*) FROM documents_document_departments',
        con=db_con
    )
    print('Number of records in documents_departments rel', count.iloc[0][0])
