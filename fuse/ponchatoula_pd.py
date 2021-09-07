import sys

import pandas as pd

from lib.path import data_file_path
from lib.columns import (
    rearrange_complaint_columns, rearrange_personnel_columns, rearrange_event_columns
)
from lib.uid import ensure_uid_unique
from lib import events

sys.path.append('../')


def fuse_events(pprr, cprr):
    builder = events.Builder()
    builder.extract_events(pprr, {
        events.OFFICER_HIRE: {
            'prefix': 'hire',
            'keep': ['uid', 'agency', 'employee_id', 'department_desc', 'salary', 'salary_freq'],
        },
        events.OFFICER_LEFT: {
            'prefix': 'termination',
            'parse_date': True,
            'keep': ['uid', 'agency', 'employee_id', 'department_desc', 'salary', 'salary_freq'],
        }
    }, ['uid'])
    builder.extract_events(cprr, {
        events.COMPLAINT_RECEIVE: {
            'prefix': 'receive',
            'parse_date': True,
            'keep': ['uid', 'complaint_uid', 'agency']
        }
    }, ['uid', 'complaint_uid'])
    return builder.to_frame()


if __name__ == '__main__':
    pprr = pd.read_csv(data_file_path(
        'clean/pprr_ponchatoula_pd_2010_2020.csv'
    ))
    cprr = pd.read_csv(data_file_path(
        'match/cprr_ponchatoula_pd_2010_2020.csv'
    ))
    post_event = pd.read_csv(data_file_path(
        'match/post_event_ponchatoula_pd_2020.csv'
    ))
    event_df = rearrange_event_columns(pd.concat([
        fuse_events(pprr, cprr),
        post_event,
    ]))
    ensure_uid_unique(event_df, 'event_uid')
    rearrange_personnel_columns(pprr).to_csv(data_file_path(
        'fuse/per_ponchatoula_pd.csv'
    ), index=False)
    rearrange_complaint_columns(cprr).to_csv(data_file_path(
        'fuse/com_ponchatoula_pd.csv'
    ), index=False)
    event_df.to_csv(data_file_path(
        'fuse/event_ponchatoula_pd.csv'), index=False)