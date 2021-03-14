import pandas as pd
from lib.path import data_file_path, ensure_data_dir
from lib.columns import (
    rearrange_personnel_columns, rearrange_personnel_history_columns, rearrange_complaint_columns
)

import sys
sys.path.append("../")


def prepare_post_data():
    post = pd.read_csv(data_file_path("clean/pprr_post_2020_11_06.csv"))
    post = post[post.agency == 'e. baton rouge so']
    post.loc[:, 'agency'] = 'Baton Rouge SO'
    return post


def fuse_personnel(cprr, post):
    records = rearrange_personnel_columns(
        cprr.set_index("uid", drop=False)).to_dict('index')
    for idx, row in rearrange_personnel_columns(post.set_index("uid", drop=False)).iterrows():
        if idx in records:
            records[idx] = {
                k: v if not pd.isnull(v) else row[k]
                for k, v in records[idx].items() if k in row}
        else:
            records[idx] = row.to_dict()
    return rearrange_personnel_columns(pd.DataFrame.from_records(list(records.values())))


def fuse_personnel_history(cprr, post):
    return rearrange_personnel_history_columns(pd.concat([cprr, post]))


if __name__ == "__main__":
    cprr = pd.read_csv(
        data_file_path("match/cprr_baton_rouge_so_2018.csv"))
    post = prepare_post_data()
    personnel_df = fuse_personnel(cprr, post)
    history_df = fuse_personnel_history(cprr, post)
    complaint_df = rearrange_complaint_columns(cprr)
    ensure_data_dir("fuse")
    personnel_df.to_csv(data_file_path(
        "fuse/per_baton_rouge_so.csv"), index=False)
    history_df.to_csv(data_file_path(
        "fuse/perhist_baton_rouge_so.csv"), index=False)
    complaint_df.to_csv(data_file_path(
        "fuse/com_baton_rouge_so.csv"), index=False)
