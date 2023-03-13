import os
import pandas as pd
# from tqdm import tqdm
from wrgl import Repository
from slack_sdk import WebClient


PERSON_COLS = {'person_id', 'canonical_uid', 'uids'}


def __retrieve_person_frm_wrgl_data(branch=None):
    repo = Repository("https://wrgl.llead.co/", None)

    # new_commit = repo.get_branch("agency-reference-list")

    original_commit = repo.get_commit("9e82d17d64a7950c731031a3e8124815")

    columns = original_commit.table.columns
    if not PERSON_COLS in set(columns):
        raise Exception('BE person columns are not recognized in the current commit')

    all_rows = list(repo.get_blocks("9e82d17d64a7950c731031a3e8124815"))
    df = pd.DataFrame(all_rows)
    df.columns = df.iloc[0]
    df = df.iloc[1:].reset_index(drop=True)

    df.to_csv('person.csv', index=False)


def __preprocess_person(officer_df):
    df = pd.read_csv('person.csv')

    result = pd.merge(df, officer_df, how='left', on='canonical_uid')

    print('Check officer id after merged')
    null_data = result[result['officer_id'].isnull()]
    if len(null_data) > 0:
        client = WebClient(os.environ.get('SLACK_BOT_TOKEN'))
        null_data.to_csv('null_officers_of_person.csv', index=False)

        # client.files_upload(
        #     channels=os.environ.get('SLACK_CHANNEL'),
        #     title="Null agency of officers",
        #     file="./null_agency_of_officers.csv",
        #     initial_comment="The following file provides a list of personnels that cannot map to agency:",
        # )

        raise Exception('Cannot map officer to person')

    result.dropna(subset=['officer_id'], inplace=True)

    # result = result.astype({
    #     'department_id': int,
    #     'birth_year': pd.Int64Dtype(),
    #     'birth_month': pd.Int64Dtype(),
    #     'birth_day': pd.Int64Dtype()
    # })
    result.to_csv('person.csv', index=False)

    print(result.head(10))


def import_person(conn):
    __retrieve_person_frm_wrgl_data()

    officer_df = pd.read_sql('SELECT id, uid FROM officers_officer', conn)
    officer_df.columns = ['officer_id', 'canonical_uid']
    # print('Check officer canonical_uid')
    # print(officer_df[officer_df['canonical_uid'].isnull()])

    __preprocess_person(officer_df)
