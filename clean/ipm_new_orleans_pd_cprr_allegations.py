from lib.path import data_file_path, ensure_data_dir
from lib.columns import clean_column_names
from lib.clean import (
    float_to_int_str, clean_sexes, clean_races, remove_future_dates, standardize_desc_cols, clean_dates
)
from lib.uid import gen_uid
import pandas as pd
import sys
sys.path.append("../")


def initial_processing():
    df = pd.read_csv(data_file_path(
        "raw/ipm/new_orleans_pd_cprr_allegations_1931-2020.csv"), escapechar="\\")
    df = df.dropna(axis=1, how="all")
    df = df.drop_duplicates()
    return clean_column_names(df)


def combine_citizen_columns(df):
    citizen_cols = [
        'allegation_primary_key', 'citizen_primary_key', 'citizen_sex', 'citizen_race'
    ]
    citizens = df[citizen_cols].dropna(how="all").drop_duplicates(subset=[
        'allegation_primary_key', 'citizen_primary_key'
    ]).set_index(['allegation_primary_key', 'citizen_primary_key'])
    citizen_dict = dict()
    for idx, frame in citizens.groupby(level=0):
        citizen_list = []
        for _, row in frame.iterrows():
            citizen = [
                x for x in [row.citizen_race, row.citizen_sex]
                if x != '' and not x.startswith('unknown')
            ]
            if len(citizen) > 0:
                citizen_list.append(' '.join(citizen))
        sexrace = ', '.join(citizen_list)
        citizen_dict[idx] = sexrace
    df.loc[:, 'citizen'] = df.allegation_primary_key\
        .map(lambda x: citizen_dict.get(x, ''))
    df = df.drop(columns=['citizen_primary_key', 'citizen_sex', 'citizen_race'])\
        .drop_duplicates().reset_index(drop=True)
    return df


def drop_rows_without_tracking_number(df):
    df = df[df.tracking_number != 'test']
    return df.dropna(subset=['tracking_number']).reset_index(drop=True)


def clean_occur_time(df):
    df.loc[:, 'occur_time'] = df.occur_time.str.replace(
        r'\.0$', '', regex=True)
    return df


def clean_trailing_empty_time(df, cols):
    for col in cols:
        df.loc[:, col] = df[col].str.replace(r' 0:00$', '', regex=True)
    return df


def clean_complainant_type(df):
    df.loc[:, 'complainant_type'] = df.complainant_type.str.lower().str.strip()\
        .str.replace(r' \# \d+$', '', regex=True).str.replace(r' complain(t|ant)$', '', regex=True)\
        .str.replace(r'civilian', 'citizen', regex=True).str.replace(r' offi$', ' office', regex=True)
    return df


def combine_rule_and_paragraph(df):
    df.loc[:, "allegation"] = df.rule_violation.str.cat(df.paragraph_violation, sep='; ')\
        .str.replace(r'^; ', '', regex=True).str.replace(r'; $', '', regex=True)\
        .str.replace(r'\bperf\b', 'performance', regex=True).str.replace('prof', 'professional', regex=False)\
        .str.replace('dept', 'department', regex=False).str.replace(r'-(\w+)', r'- \1', regex=True)\
        .str.replace(r'no violation observed;? '
                     r'?(no violation was observed to have been committed)?|'
                     r'no alligations assigned at this time', '', regex=True)\
        .str.replace(r'\binfo\b', 'information', regex=True).str.replace('mobil', 'mobile', regex=False)\
        .str.replace('drugs off- duty', 'drugs while off duty', regex=False)\
        .str.replace(r'social networking(.+)', 'social networking', regex=True)\
        .str.replace(', giving', ' or giving', regex=False)\
        .str.replace('professionalessionalism', 'professionalism', regex=False)\
        .str.replace(r'^policy$', '', regex=True).str.replace('perform before', 'perform duty before', regex=False)\
        .str.replace('use of alcohol / on- duty', 'use of alcohol while on duty')\
        .str.replace('use of alcohol / off- duty', 'use of alcohol while off duty', regex=False)\
        .str.replace(r'(\w+) / (\w+)', r'\1/\2', regex=True)\
        .str.replace('department property', 'department equipment', regex=False)\
        .str.replace('civil service rules; rule v, section 9 - to wit paragraph 1 and paragraph 18', '', regex=False)\
        .str.replace('paragraph 05 - ceasing to perform duty before end of shift',
                     'paragraph 03 - devoting entire time to duty', regex=False)\
        .str.replace('rest activities', 'restricted activities', regex=False)\
        .str.replace('from authoritative', 'from an authoritative', regex=False)\
        .str.replace('paprgraph', 'paragraph', regex=False)\
        .str.replace('digital mobile video audio recording', 'digital, mobile, video, or audio recording', regex=False)\
        .str.replace(r'\bparagraph 1\b', 'paragraph 01', regex=True)\
        .str.replace('policy;', 'policy:', regex=False)
    df = df.drop(columns=['rule_violation', 'paragraph_violation'])
    return df


def assign_agency(df):
    df.loc[:, 'data_production_year'] = '2020'
    df.loc[:, 'agency'] = 'New Orleans PD'
    return df


def discard_allegations_with_same_description(df):
    finding_cat = pd.CategoricalDtype(categories=[
        'sustained',
        'exonerated',
        'illegitimate outcome',
        'counseling',
        'mediation',
        'not sustained',
        'unfounded',
        'no investigation merited',
        'pending'
    ], ordered=True)
    df.loc[:, 'allegation_finding'] = df.allegation_finding.replace({
        'di-2': 'counseling',
        'nfim': 'no investigation merited'
    }).astype(finding_cat)
    return df.sort_values(['tracking_number', 'complaint_uid', 'allegation_finding'])\
        .drop_duplicates(subset=['complaint_uid'], keep='first')\
        .reset_index(drop=True)


def remove_rows_with_conflicting_disposition(df):
    df.loc[df.allegation_finding == 'sustained', 'disposition'] = 'sustained'
    return df


def clean_tracking_number(df):
    df.loc[:, 'tracking_number'] = df.tracking_number\
        .str.replace(r'^Rule9-', '', regex=True)
    for idx, row in df.loc[df.tracking_number.str.match(r'^\d{3}-')].iterrows():
        df.loc[idx, 'tracking_number'] = row.allegation_create_year + row.tracking_number[3:]
    return df


def replace_disposition(df):
    df.loc[:, 'disposition'] = df.disposition.replace({
        'di-2': 'counseling',
        'nfim': 'no investigation merited'
    })
    return df


def clean():
    df = initial_processing()
    return df\
        .drop(columns=[
            'all_findings', 'allegation_1', 'allegation_alert_processed', 'allegation_alert_processed_date',
            'allegation_class_1', 'allegation_directive', 'allegation_final_disposition',
            'allegation_final_disposition_date', 'allegation_finding', 'allegation_finding_date', 'assigned_date',
            'citizen_age', 'citizen_num_shots', 'completed_date', 'county',
            'created_date', 'day_of_week', 'disposition_nopd', 'due_date', 'field_unit_level',
            'hour_of_day', 'is_anonymous', 'length_of_job', 'month_occurred', 'officer_age_at_time_of_uof',
            'officer_badge_number', 'officer_current_supervisor', 'officer_department', 'officer_division',
            'officer_employment_status', 'officer_race', 'officer_sex', 'officer_sub_division_a',
            'officer_sub_division_b', 'officer_title', 'officer_type', 'officer_unknown_id',
            'officer_years_exp_at_time_of_uof', 'officer_years_with_unit', 'open_date', 'priority', 'service_type',
            'shift_details', 'status', 'sustained', 'unidentified_officer', 'why_forwarded', 'working_status',
            'year_occurred', 'allegation', 'citizen_involvement', 'allegation_class', 'cit_complaint'
        ])\
        .drop_duplicates()\
        .dropna(how="all")\
        .rename(columns={
            'pib_control_number': 'tracking_number',
            'occurred_date': 'occur_date',
            'disposition_oipm_by_officer': 'disposition',
            'ocurred_time': 'occur_time',
            'received_date': 'receive_date',
            'source': 'complainant_type',
            'allegation_finding_oipm': 'allegation_finding',
            'allegation_created_on': 'allegation_create_date'
        })\
        .pipe(drop_rows_without_tracking_number)\
        .pipe(clean_sexes, ['citizen_sex'])\
        .pipe(clean_races, ['citizen_race'])\
        .pipe(combine_citizen_columns)\
        .pipe(standardize_desc_cols, [
            'incident_type', 'disposition', 'rule_violation', 'paragraph_violation',
            'traffic_stop', 'body_worn_camera_available', 'citizen_arrested', 'allegation_finding'
        ])\
        .pipe(float_to_int_str, [
            'officer_primary_key', 'allegation_primary_key'
        ])\
        .pipe(clean_occur_time)\
        .pipe(clean_trailing_empty_time, ['receive_date', 'allegation_create_date'])\
        .pipe(clean_dates, ['receive_date', 'allegation_create_date', 'occur_date'])\
        .pipe(clean_tracking_number)\
        .pipe(clean_complainant_type)\
        .pipe(combine_rule_and_paragraph)\
        .pipe(assign_agency)\
        .pipe(gen_uid, [
            'agency', 'tracking_number', 'officer_primary_key', 'allegation'
        ], 'complaint_uid')\
        .pipe(discard_allegations_with_same_description)\
        .pipe(replace_disposition)\
        .pipe(remove_future_dates, '2020-12-31', ['receive', 'allegation_create', 'occur'])


if __name__ == '__main__':
    df = clean()
    ensure_data_dir('clean')
    df.to_csv(data_file_path(
        'clean/cprr_new_orleans_pd_1931_2020.csv'), index=False)
