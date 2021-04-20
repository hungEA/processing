from lib.columns import clean_column_names
from lib.path import data_file_path, ensure_data_dir
from lib.clean import clean_dates, clean_names, float_to_int_str, standardize_desc_cols
from lib.uid import gen_uid
import pandas as pd
import sys
sys.path.append('../')


def assign_agency(df):
    df.loc[:, 'agency'] = 'St. Tammany SO'
    df.loc[:, 'data_production_year'] = 2020
    return df


def clean():
    df = pd.read_csv(
        data_file_path('st_tammany_so/st._tammany_so_pprr_2020.csv')
    )
    df = clean_column_names(df)
    df = df.rename(columns={
        'job_class': 'rank_code',
        'job_class_desc': 'rank_desc',
        'year_of_birth': 'birth_year'
    })
    return df\
        .pipe(float_to_int_str, ['birth_year'])\
        .pipe(standardize_desc_cols, ['rank_desc'])\
        .pipe(clean_dates, ['hire_date', 'term_date'])\
        .pipe(assign_agency)\
        .pipe(clean_names, ['first_name', 'last_name'])\
        .pipe(gen_uid, ['agency', 'employee_id', 'first_name', 'last_name', 'birth_year'])\
        .pipe(gen_uid, ['uid', 'hire_year', 'hire_month', 'hire_day'], 'perhist_uid')


if __name__ == '__main__':
    df = clean()
    ensure_data_dir('clean')
    df.to_csv(data_file_path('clean/pprr_st_tammany_so_2020.csv'), index=False)
