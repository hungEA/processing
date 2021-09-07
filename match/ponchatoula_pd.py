import sys

import pandas as pd
from datamatch import ThresholdMatcher, JaroWinklerSimilarity, ColumnsIndex

from lib.path import data_file_path
from lib.post import extract_events_from_post

sys.path.append('../')


def extract_post_events(pprr, post):
    post = post.loc[post.agency == 'ponchatoula pd']

    dfa = pprr[['first_name', 'last_name', 'uid']]
    dfa.loc[:, 'fc'] = dfa.first_name.fillna('').map(lambda x: x[:1])
    dfa = dfa.drop_duplicates().set_index('uid', drop=True)

    dfb = post[['last_name', 'first_name', 'uid']]
    dfb.loc[:, 'fc'] = dfb.first_name.fillna('').map(lambda x: x[:1])
    dfb = dfb.drop_duplicates(subset=['uid']).set_index('uid', drop=True)

    matcher = ThresholdMatcher(ColumnsIndex(['fc']), {
        'first_name': JaroWinklerSimilarity(),
        'last_name': JaroWinklerSimilarity(),
    }, dfa, dfb)
    decision = 0.95
    matcher.save_pairs_to_excel(data_file_path(
        "match/ponchatoula_pd_pprr_2010_2020_v_post_pprr_2020_11_06.xlsx"), decision)
    matches = matcher.get_index_pairs_within_thresholds(lower_bound=decision)

    return extract_events_from_post(post, matches, "Ponchatoula PD")


def match_cprr_and_pprr(cprr, pprr):
    dfa = cprr[['first_name', 'last_name', 'uid']]
    dfa.loc[:, 'fc'] = dfa.first_name.fillna('').map(lambda x: x[:1])
    dfa = dfa.drop_duplicates().set_index('uid', drop=True)

    dfb = pprr[['last_name', 'first_name', 'uid']]
    dfb.loc[:, 'fc'] = dfb.first_name.fillna('').map(lambda x: x[:1])
    dfb = dfb.drop_duplicates(subset=['uid']).set_index('uid', drop=True)

    matcher = ThresholdMatcher(ColumnsIndex(['fc']), {
        'first_name': JaroWinklerSimilarity(),
        'last_name': JaroWinklerSimilarity(),
    }, dfa, dfb)
    decision = 0.95
    matcher.save_pairs_to_excel(data_file_path(
        "match/ponchatoula_pd_cprr_2010_2020_v_pprr_2010_2020.xlsx"), decision)
    matches = matcher.get_index_pairs_within_thresholds(lower_bound=decision)
    match_dict = dict(matches)

    cprr.loc[:, 'uid'] = cprr.uid.map(lambda x: match_dict.get(x, x))
    return cprr


if __name__ == '__main__':
    pprr = pd.read_csv(data_file_path('clean/pprr_ponchatoula_pd_2010_2020.csv'))
    cprr = pd.read_csv(data_file_path('clean/cprr_ponchatoula_pd_2010_2020.csv'))
    post = pd.read_csv(data_file_path('clean/pprr_post_2020_11_06.csv'))
    cprr = match_cprr_and_pprr(cprr, pprr)
    post_events = extract_post_events(pprr, post)
    post_events.to_csv(data_file_path(
        "match/post_event_ponchatoula_pd_2020.csv",
    ), index=False)
    cprr.to_csv(data_file_path(
        'match/cprr_ponchatoula_pd_2010_2020.csv',
    ), index=False)