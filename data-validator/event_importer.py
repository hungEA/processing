import os
import numpy as np
import pandas as pd
from slack_sdk import WebClient
# from wrgl import Repository


EVENT_COLS = [
    'event_uid', 'kind', 'year', 'month', 'day', 'time', 'raw_date', 'uid',
    'allegation_uid', 'appeal_uid', 'uof_uid', 'agency', 'badge_no',
    'department_code', 'department_desc', 'division_desc', 'rank_code',
    'rank_desc', 'salary', 'overtime_annual_total', 'salary_freq', 'left_reason'
]


# def __retrieve_event_frm_wrgl_data():
#     repo = Repository("https://wrgl.llead.co/", None)

#     original_commit = repo.get_branch("event")

#     columns = original_commit.table.columns
#     if not set(EVENT_COLS).issubset(set(columns)):
#         raise Exception('BE event columns are not recognized in the current commit')

#     all_rows = list(repo.get_blocks("heads/event"))
#     df = pd.DataFrame(all_rows)
#     df.columns = df.iloc[0]
#     df = df.iloc[1:].reset_index(drop=True)

#     df = df.loc[:, EVENT_COLS]
#     df.to_csv('events.csv', index=False)


def __build_event_rel(db_con):
    client = WebClient(os.environ.get('SLACK_BOT_TOKEN'))
    events_df = pd.read_csv('events.csv')

    print('Building relationship between officers and events')
    officers_df = pd.read_sql(
        'SELECT id, uid, agency FROM officers_officer',
        con=db_con
    )
    officers_df.columns = ['officer_id', 'uid', 'officer_agency']

    no_officers_in_events = events_df['uid'].dropna().unique()
    print('Number of officers in WRGL event', len(no_officers_in_events))
    diff_officers = set(no_officers_in_events) - set(officers_df['uid'])
    print('Number of differences in officers', len(diff_officers))

    if len(diff_officers) > 0:
        with open('diff_officers_in_event.csv', 'w') as fwriter:
            fwriter.write('\n'.join(list(diff_officers)))

        client.files_upload(
            channels=os.environ.get('SLACK_CHANNEL'),
            title="Diff of officers in event",
            file="./diff_officers_in_event.csv",
            initial_comment="The following file provides a list of uid in event that cannot map to officers:",
        )
        raise Exception('There is anomaly in the number of officers in events')

    print('Building events_agency relationship')
    agency_df = pd.read_sql(
        'SELECT id, agency_slug FROM departments_department',
        con=db_con
    )
    agency_df.columns = ['department_id', 'agency']

    no_agency_in_events = events_df['agency'].dropna().unique()
    print('Number of agency in WRGL events', len(no_agency_in_events))
    diff_agency = set(no_agency_in_events) - set(agency_df['agency'])
    print('Number of differences in agency', len(diff_agency))

    if len(diff_agency) > 0:
        with open('diff_agency_in_events.csv', 'w') as fwriter:
            fwriter.write('\n'.join(list(diff_agency)))

        client.files_upload(
            channels=os.environ.get('SLACK_CHANNEL'),
            title="diff of agency in event",
            file="./diff_agency_in_events.csv",
            initial_comment="The following file provides a list of agency in event that cannot map to department:",
        )

        raise Exception('There is anomaly in the number of agency in event')

    print('Building events_appeal relationship')
    appeal_df = pd.read_sql(
        'SELECT id, appeal_uid FROM appeals_appeal',
        con=db_con
    )
    appeal_df.columns = ['appeal_id', 'appeal_uid']

    no_appeal_in_events = events_df['appeal_uid'].dropna().unique()
    print('Number of appeal in WRGL events', len(no_appeal_in_events))
    diff_appeal = set(no_appeal_in_events) - set(appeal_df['appeal_uid'])
    print('Number of differences in appeal', len(diff_appeal))

    if len(diff_appeal) > 0:
        with open('diff_appeal_in_events.csv', 'w') as fwriter:
            fwriter.write('\n'.join(list(diff_appeal)))

        client.files_upload(
            channels=os.environ.get('SLACK_CHANNEL'),
            title="diff of appeal in event",
            file="./diff_appeal_in_events.csv",
            initial_comment="The following file provides a list of appeal in event that cannot map to appeal:",
        )

        raise Exception('There is anomaly in the number of appeal in event')

    print('Building events_uof relationship')
    uof_df = pd.read_sql(
        'SELECT id, uof_uid FROM use_of_forces_useofforce',
        con=db_con
    )
    uof_df.columns = ['uof_id', 'uof_uid']

    no_uof_in_events = events_df['uof_uid'].dropna().unique()
    print('Number of uof in WRGL events', len(no_uof_in_events))
    diff_uof = set(no_uof_in_events) - set(uof_df['uof_uid'])
    print('Number of differences in uof', len(diff_uof))

    if len(diff_uof) > 0:
        with open('diff_uof_in_events.csv', 'w') as fwriter:
            fwriter.write('\n'.join(list(diff_uof)))

        client.files_upload(
            channels=os.environ.get('SLACK_CHANNEL'),
            title="Diff use-of-force in event",
            file="./diff_uof_in_events.csv",
            initial_comment="The following file provides a list of use-of-force in event that cannot map to use-of-force:",
        )

        raise Exception('There is anomaly in the number of use-of-force in event')

    print('Check for integrity of officer agency and agency')
    check_agency_df = events_df.loc[:, ['event_uid', 'uid', 'agency']]
    check_agency_df.dropna(subset=['uid', 'agency'], inplace=True)
    check_agency_df = pd.merge(check_agency_df, officers_df, how='left', on='uid')

    diff_check_agency = check_agency_df[check_agency_df['officer_agency'] != check_agency_df['agency']]
    if len(diff_check_agency) > 0:
        diff_check_agency.drop_duplicates(inplace=True)
        diff_check_agency.to_csv(
            'diff_officers_agency_of_event.csv',
            columns=['event_uid', 'agency', 'uid', 'officer_agency'],
            index=False
        )

        client.files_upload(
            channels=os.environ.get('SLACK_CHANNEL'),
            title="Diff of officer agency of event",
            file="./diff_officers_agency_of_event.csv",
            initial_comment="The following file provides a list of officers that have conflicting agency in event:",
        )

        raise Exception('There are discrepancy between agency of officers and events')

    result = pd.merge(events_df, officers_df, how='left', on='uid')
    result = pd.merge(result, agency_df, how='left', on='agency')
    result = pd.merge(result, appeal_df, how='left', on='appeal_uid')
    result = pd.merge(result, uof_df, how='left', on='uof_uid')

    result = result.loc[:, EVENT_COLS + ['officer_id', 'department_id', 'appeal_id', 'uof_id']]

    result = result.astype({
        'year': pd.Int64Dtype(),
        'month': pd.Int64Dtype(),
        'day': pd.Int64Dtype(),
        'officer_id': pd.Int64Dtype(),
        'department_id': pd.Int64Dtype(),
        'appeal_id': pd.Int64Dtype(),
        'uof_id': pd.Int64Dtype()
    })
    result.to_csv('events.csv', index=False)


def import_event(db_con):
    # __retrieve_event_frm_wrgl_data()
    event_df = pd.read_csv(
        os.path.join(os.environ.get('DATA_DIR'), 'event.csv')
    )
    event_df = event_df.loc[:, EVENT_COLS]
    event_df.to_csv('events.csv', index=False)

    __build_event_rel(db_con)

    cursor = db_con.cursor()
    cursor.copy_expert(
        sql="""
            COPY officers_event(
                event_uid, kind, year, month, day, time, raw_date, uid,
                allegation_uid, appeal_uid, uof_uid, agency, badge_no,
                department_code, department_desc, division_desc, rank_code,
                rank_desc, salary, overtime_annual_total, salary_freq,
                left_reason, officer_id, department_id, appeal_id, use_of_force_id
            ) FROM stdin WITH CSV HEADER
            DELIMITER as ','
        """,
        file=open('events.csv', 'r'),
    )
    db_con.commit()
    cursor.close()

    count = pd.read_sql(
        'SELECT COUNT(*) FROM officers_event',
        con=db_con
    )
    print('Number of records in event', count.iloc[0][0])
