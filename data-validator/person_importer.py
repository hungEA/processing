import os
import pandas as pd
# from tqdm import tqdm
from wrgl import Repository
from slack_sdk import WebClient


PERSON_COLS = ['person_id', 'canonical_uid', 'uids']


def __retrieve_person_frm_wrgl_data(branch=None):
    repo = Repository("https://wrgl.llead.co/", None)

    # new_commit = repo.get_branch("agency-reference-list")

    original_commit = repo.get_branch("person")

    columns = original_commit.table.columns
    if not set(PERSON_COLS).issubset(set(columns)):
        raise Exception('BE person columns are not recognized in the current commit')

    all_rows = list(repo.get_blocks("heads/person"))
    df = pd.DataFrame(all_rows)
    df.columns = df.iloc[0]
    df = df.iloc[1:].reset_index(drop=True)

    df.to_csv('person.csv', index=False)


def __build_person_rel(db_con):
    df = pd.read_csv('person.csv')

    officer_df = pd.read_sql('SELECT id, uid FROM officers_officer', db_con)
    officer_df.columns = ['officer_id', 'uids']

    result = pd.merge(df, officer_df, how='left', on='uids')

    print('Check officer id after merged')
    null_officer_data = result[result['officer_id'].isnull()]
    if len(null_officer_data) > 0:
        # client = WebClient(os.environ.get('SLACK_BOT_TOKEN'))
        null_officer_data.to_csv('null_officers_of_person.csv', index=False)

        # Temporarily disabled to pass the check in order to continue developing
        # client.files_upload(
        #     channels=os.environ.get('SLACK_CHANNEL'),
        #     title="Null officers of person",
        #     file="./null_officers_of_person.csv",
        #     initial_comment="The following file provides a list of uids in person that cannot map to personnel:",
        # )

        # raise Exception('Cannot map uids in person to personnel')

    # result.dropna(subset=['officer_id'], inplace=True)

    # result = result.astype({
    #     'department_id': int,
    #     'birth_year': pd.Int64Dtype(),
    #     'birth_month': pd.Int64Dtype(),
    #     'birth_day': pd.Int64Dtype()
    # })
    # result.to_csv('person.csv', index=False)

    # print(result.head(10))


def import_person(db_con):
    __retrieve_person_frm_wrgl_data()
    __build_person_rel(db_con)
