import os
import pandas as pd
from tqdm import tqdm
from wrgl import Repository


AGENCY_COLS = {'agency_slug', 'agency_name', 'location'}


def __retrieve_wrgl_data(self, branch=None):
    repo = Repository("https://wrgl.llead.co/")

    # new_commit = repo.get_branch("agency-reference-list")

    original_commit = repo.get_commit("596ae27e2528559798f416348529a35c")

    columns = original_commit.table.columns
    assert set(columns) == AGENCY_COLS

    result = repo.diff(original_commit, None)

    added_rows = columns
    with tqdm(
        total=len(result), desc="Downloading created data"
    ) as pbar:
        for i in range(0, len(result), 1000):
            added_rows.extend(
                list(
                    repo.get_table_rows(
                        original_commit.table.sum,
                        result[i : i + 1000],
                    )
                )
            )
            pbar.update(1000)

    df = pd.DataFrame(added_rows)
    df.columns = df.iloc[0]
    df = df.iloc[1:].reset_index(drop=True)

    return df



def import_department(conn):
    data = __retrieve_wrgl_data()
    data.to_sql('departments_department', con=conn, if_exists='replace', index=False)

    df = pd.read_sql('SELECT * FROM departments_department', con=conn)

    print(df.head(10))
