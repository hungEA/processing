import os
import pandas as pd
# from tqdm import tqdm
from wrgl import Repository


OFFICER_COLS = {
    'uid', 'last_name', 'middle_name', 'first_name', 'birth_year',
    'birth_month', 'birth_day', 'race', 'sex', 'agency'
}


def __retrieve_officer_frm_wrgl_data(branch=None):
    repo = Repository("https://wrgl.llead.co/", None)

    # new_commit = repo.get_branch("agency-reference-list")

    original_commit = repo.get_commit("9e82d17d64a7950c731031a3e8124815")

    columns = original_commit.table.columns
    assert set(columns) == OFFICER_COLS

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
    all_rows = list(repo.get_blocks("9e82d17d64a7950c731031a3e8124815"))
    df = pd.DataFrame(all_rows)
    df.columns = df.iloc[0]
    df = df.iloc[1:].reset_index(drop=True)

    df.to_csv('officer.csv', index=False)

    print(df.head(10))


def __preprocess_officer(agency_df):
    df = pd.read_csv('officer.csv')

    result = pd.merge(df, agency_df, how='left', on='agency')

    result.to_csv('officer.csv', index=False)



def import_officer(conn):
    # cursor = conn.cursor()
    # cursor.execute("""SELECT table_name FROM information_schema.tables
    #    WHERE table_schema = 'public'""")
    # for table in cursor.fetchall():
    #     print(table)

    # cursor.close()

    __retrieve_officer_frm_wrgl_data()


    agency_df = pd.read_sql('SELECT id, agency_slug FROM departments_department', conn)
    agency_df.columns = ['department_id', 'agency']
    __preprocess_officer(agency_df)

    # data = pd.read_csv('agency.csv')
    # data.to_sql('departments_department', con=conn, if_exists='replace', index=False)
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

    print(df.head(10))
