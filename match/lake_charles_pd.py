import sys
sys.path.append('../')
import pandas as pd
from datamatch import JaroWinklerSimilarity, ThresholdMatcher, ColumnsIndex
from lib.path import data_file_path, ensure_data_dir


def assign_first_name_from_post(cprr, post):
    dfa = cprr.loc[cprr.uid.notna(), ['uid', 'first_name', 'last_name']].drop_duplicates(subset=['uid'])\
        .set_index('uid', drop=True)
    dfa.loc[:, 'fc'] = dfa.last_name.fillna('').map(lambda x: x[:1])

    dfb = post[['uid', 'first_name', 'last_name']].drop_duplicates()\
        .set_index('uid', drop=True)
    dfb.loc[:, 'fc'] = dfb.last_name.fillna('').map(lambda x: x[:1])

    matcher = ThresholdMatcher(ColumnsIndex('fc'), {
        'last_name': JaroWinklerSimilarity(),
    }, dfa, dfb)
    decision = 0.97

    matcher.save_pairs_to_excel(data_file_path(
        "match/lake_charles_pd_cprr_2020_assign_first_name_from_post_pprr_2020_11_06.xlsx"), decision)
    matches = matcher.get_index_pairs_within_thresholds(decision)
    match_dict = dict(matches)

    cprr.loc[:, 'first_name'] = cprr.first_name.map(lambda x: match_dict.get(x, x))
    return cprr


def assign_uid_from_post(cprr, post):
    dfa = cprr.loc[cprr.uid.notna(), ['uid', 'first_name', 'last_name']].drop_duplicates(subset=['uid'])\
        .set_index('uid', drop=True)
    dfa.loc[:, 'fc'] = dfa.first_name.fillna('').map(lambda x: x[:1])

    dfb = post[['uid', 'first_name', 'last_name']].drop_duplicates()\
        .set_index('uid', drop=True)
    dfb.loc[:, 'fc'] = dfb.first_name.fillna('').map(lambda x: x[:1])

    matcher = ThresholdMatcher(ColumnsIndex('fc'), {
        'first_name': JaroWinklerSimilarity(),
        'last_name': JaroWinklerSimilarity(),
    }, dfa, dfb)
    decision = 0.93
    matcher.save_pairs_to_excel(data_file_path(
        "match/lake_charles_pd_cprr_20_v_post_pprr_2020_11_06.xlsx"), decision)
    matches = matcher.get_index_pairs_within_thresholds(decision)
    match_dict = dict(matches)

    cprr.loc[:, 'uid'] = cprr.uid.map(lambda x: match_dict.get(x, x))
    return cprr


if __name__ == '__main__':
    cprr = pd.read_csv(data_file_path('clean/cprr_lake_charles_pd_2020.csv'))
    post = pd.read_csv(data_file_path('clean/pprr_post_2020_11_06.csv'))
    post = post[post.agency == 'lake charles pd']
    ensure_data_dir('match')
    cprr = assign_first_name_from_post(cprr, post)
    cprr = assign_uid_from_post(cprr, post)
    cprr.to_csv(data_file_path(
        'match/cprr_lake_charles_pd_2020.csv'), index=False)