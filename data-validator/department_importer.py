import os
import pandas as pd
# from wrgl import Repository


AGENCY_COLS = ['agency_slug', 'agency_name', 'location']


# def __retrieve_wrgl_data(branch=None):
#     repo = Repository("https://wrgl.llead.co/", None)

#     original_commit = repo.get_branch("agency-reference-list")

#     columns = original_commit.table.columns
#     if not set(AGENCY_COLS).issubset(set(columns)):
#         raise Exception('BE agency columns are not recognized in the current commit')

#     all_rows = list(repo.get_blocks("heads/agency-reference-list"))
#     df = pd.DataFrame(all_rows)
#     df.columns = df.iloc[0]
#     df = df.iloc[1:].reset_index(drop=True)

#     df.to_csv('agency.csv', index=False)


def import_department(db_con):
    agency_df = pd.read_csv(
        os.path.join(os.environ.get('DATA_DIR'), 'agency_reference_list.csv')
    )
    agency_df = agency_df.loc[:, AGENCY_COLS]
    agency_df.to_csv('agency.csv', index=False)

    cursor = db_con.cursor()
    cursor.copy_expert(
        sql="""
            COPY departments_department(agency_slug, agency_name, location)
            FROM stdin WITH CSV HEADER
            DELIMITER as ','
        """,
        file=open('agency.csv', 'r'),
    )
    db_con.commit()
    cursor.close()

    df = pd.read_sql(
        'SELECT agency_slug, agency_name, location FROM departments_department',
        con=db_con
    )

    print('List top 10 agency')
    print(df.head(10))
