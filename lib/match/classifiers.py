import math
from enum import Enum
import pandas as pd


class MatchStatus(Enum):
    NO = 1
    MAYBE = 2
    YES = 3


class ThresholdClassifier(object):
    """
    For each pair compute similarity vector and combine into a single
    similarity value using euclidean distance and normalize so it fit into 0-1 range.
    Finally classify into matches, potential matches, non-matches with 2 thresholds.
    """

    def __init__(self, fields, thresholds=[1, 0.5]):
        self._fields = fields
        self._thresholds = thresholds

    def classify(self, rec_a, rec_b):
        sim_vec = dict()
        for k, scls in self._fields.items():
            if pd.isnull(rec_a[k]) or pd.isnull(rec_b[k]):
                sim_vec[k] = 0
            else:
                sim_vec[k] = scls.sim(rec_a[k], rec_b[k])
        sim = math.sqrt(
            sum(v * v for v in sim_vec.values()) / len(self._fields))
        if sim >= self._thresholds[0]:
            return MatchStatus.YES
        if len(self._thresholds) > 1 and sim >= self._thresholds[1]:
            return MatchStatus.MAYBE
        return MatchStatus.NO