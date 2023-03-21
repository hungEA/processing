import os
import pandas as pd
from wrgl import Repository


AGENCY_COLS = ['agency_slug', 'agency_name', 'location']


def __retrieve_wrgl_data(branch=None):
    repo = Repository("https://wrgl.llead.co/", None)

    original_commit = repo.get_branch("agency-reference-list")

    columns = original_commit.table.columns
    if not set(AGENCY_COLS).issubset(set(columns)):
        raise Exception('BE agency columns are not recognized in the current commit')

    all_rows = list(repo.get_blocks("heads/agency-reference-list"))
    df = pd.DataFrame(all_rows)
    df.columns = df.iloc[0]
    df = df.iloc[1:].reset_index(drop=True)

    df.to_csv('agency.csv', index=False)


def import_department(conn):
    # cursor = conn.cursor()
    # cursor.execute("""SELECT table_name FROM information_schema.tables
    #    WHERE table_schema = 'public'""")
    # for table in cursor.fetchall():
    #     print(table)

    # cursor.close()

    __retrieve_wrgl_data()

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
