import os
import pandas as pd
# from tqdm import tqdm
from wrgl import Repository


AGENCY_COLS = ['agency_slug', 'agency_name', 'location']


def __retrieve_wrgl_data(branch=None):
    repo = Repository("https://wrgl.llead.co/", None)

    # new_commit = repo.get_branch("agency-reference-list")

    original_commit = repo.get_branch("agency-reference-list")

    columns = original_commit.table.columns
    if not set(AGENCY_COLS).issubset(set(columns)):
        raise Exception('BE agency columns are not recognized in the current commit')

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
    all_rows = list(repo.get_blocks("heads/agency-reference-list"))
    df = pd.DataFrame(all_rows)
    df.columns = df.iloc[0]
    df = df.iloc[1:].reset_index(drop=True)

    df.to_csv('agency.csv', index=False)

    # print(df.head(10))


def import_department(conn):
    # cursor = conn.cursor()
    # cursor.execute("""SELECT table_name FROM information_schema.tables
    #    WHERE table_schema = 'public'""")
    # for table in cursor.fetchall():
    #     print(table)

    # cursor.close()

    __retrieve_wrgl_data()

    # data = pd.read_csv('agency.csv')
    # data.to_sql('departments_department', con=conn, if_exists='replace', index=False)
    cursor = conn.cursor()
    cursor.copy_expert(
        sql="""
            COPY departments_department(agency_slug, agency_name, location) FROM stdin WITH CSV HEADER
            DELIMITER as ','
        """,
        file=open('agency.csv', 'r'),
    )
    conn.commit()
    cursor.close()

    df = pd.read_sql('SELECT agency_slug, agency_name, location FROM departments_department', con=conn)

    print('List top 10 agency')
    print(df.head(10))
