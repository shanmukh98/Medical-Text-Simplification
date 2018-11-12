# -*- coding: utf-8 -*-

"""
The phrasefinder module provides routines for querying the PhraseFinder web service at
https://phrasefinder.io.

:copyright: 2016-2018 Martin Trenkmann.
:license: Apache 2.0, see LICENSE for more details.
"""

from enum import Enum, unique
import requests

__version__ = '0.6.0'

BASE_URL = 'https://api.phrasefinder.io'  # read-only

@unique
class Corpus(Enum):
    """
    Contains numeric constants that represent available corpora to be searched.

    All corpora belong to version 2 of the Google Books Ngram Dataset
    (http://storage.googleapis.com/books/ngrams/books/datasetsv2.html).
    """

    NULL = 0
    AMERICAN_ENGLISH = 1
    BRITISH_ENGLISH = 2
    CHINESE = 3
    FRENCH = 4
    GERMAN = 5
    RUSSIAN = 6
    SPANISH = 7

    def __str__(self):
        return self.short_name()

    def short_name(self):
        """
        Returns the short name of this enum constant.
        """
        return {
            0: 'null',
            1: 'eng-us',
            2: 'eng-gb',
            3: 'chi',
            4: 'fre',
            5: 'ger',
            6: 'rus',
            7: 'spa'
        }[self.value]

class Token(object):
    """
    Represents a single token (word, punctuation mark, etc.) as part of a phrase.
    """

    @unique
    class Tag(Enum):
        """
        Denotes the role of a token with respect to the query.
        """

        GIVEN = 0
        INSERTED = 1
        ALTERNATIVE = 2
        COMPLETED = 3

    def __init__(self):
        self.text = ''
        self.tag = Token.Tag.GIVEN

class Phrase(object):
    """
    Represents a phrase, also called n-gram.

    A phrase consists of a sequence of tokens and metadata.
    """

    def __init__(self):
        self.tokens = []       # The tokens of the phrase.
        self.match_count = 0   # The absolute frequency in the corpus.
        self.volume_count = 0  # The number of books it appears in.
        self.first_year = 0    # Publication date of the first book it appears in.
        self.last_year = 0     # Publication date of the last book it appears in.
        self.score = 0.0       # The relative frequency it matched the given query.
        self.id = 0            # See the API documentation on the website.

    @staticmethod
    def parse(line):
        """
        Parses a phrase from a line of text.

        :param line:
            A string containing a TSV-encoded phrase.

        :returns:
            A phrase object.
        """
        phrase = Phrase()
        parts = line.split('\t')
        for token_with_tag in parts[0].split(' '):
            token = Token()
            token.text = token_with_tag[:-2]
            token.tag = int(token_with_tag[-1])
            phrase.tokens.append(token)
        phrase.match_count = int(parts[1])
        phrase.volume_count = int(parts[2])
        phrase.first_year = int(parts[3])
        phrase.last_year = int(parts[4])
        phrase.id = int(parts[5])
        phrase.score = float(parts[6])
        return phrase

class SearchOptions(object):
    """
    Represents optional parameters that may be sent along with a query.
    """

    DEFAULT_NMIN = 1    # read-only
    DEFAULT_NMAX = 5    # read-only
    DEFAULT_TOPK = 100  # read-only

    def __init__(self):
        self.nmin = SearchOptions.DEFAULT_NMIN
        self.nmax = SearchOptions.DEFAULT_NMAX
        self.topk = SearchOptions.DEFAULT_TOPK

class SearchResult(object):
    """
    Represents the outcome of a request.

    If a request was successful, the ``error_message`` attribute is ``None`` and the ``phrases``
    attribute contains matching ``Phrase`` objects. If a request failed, ``error_message`` contains
    a string indicating the reason. In that case ``phrases`` is empty.
    """

    def __init__(self, error_message=None):
        self.error_message = error_message
        self.phrases = []  # List of Phrase instances.

class BatchRequest(object):
    """
    Represents a container for a list of requests and other parameters that are sent to the
    PhraseFinder server using a single HTTP request.
    """

    def __init__(self):
        self.params = {}
        self.requests = []

    def execute(self):
        """
        Sends the batch request to the server and receives the response.

        :returns:
            A list of ``SearchResult`` objects.
        """
        payload = self.params.copy()
        payload['batch'] = self.requests
        if 'corpus' in payload:
            payload['corpus'] = str(payload['corpus'])
        response = requests.post(BASE_URL, json=payload)
        if response.status_code != 200:
            raise Exception(response.json()['error']['message'])
        results = []
        lines = response.iter_lines(decode_unicode=True)
        while True:
            try:
                line = next(lines)
                status, other = line.split(' ', 1)
                if status == 'OK':
                    nlines = int(other)
                    result = SearchResult()
                    try:
                        for _ in range(nlines):
                            line = next(lines)
                            result.phrases.append(Phrase.parse(line))
                        results.append(result)
                    except StopIteration:
                        raise Exception('Incomplete response body')
                elif status == 'ERROR':
                    results.append(SearchResult(other))
                else:
                    raise Exception('Malformed response body')
            except StopIteration:
                break
        return results

def search(corpus, query, options=SearchOptions()):
    """
    Sends a request to the server.

    :returns:
        A ``SearchResult`` object. Functional errors are reported raising an exception.
    """
    payload = {'corpus': corpus.short_name(), 'query': query, 'format': 'tsv'}
    if options.nmin != SearchOptions.DEFAULT_NMIN:
        payload['nmin'] = options.nmin
    if options.nmax != SearchOptions.DEFAULT_NMAX:
        payload['nmax'] = options.nmax
    if options.topk != SearchOptions.DEFAULT_TOPK:
        payload['topk'] = options.topk
    response = requests.get(BASE_URL, params=payload)
    if response.status_code != 200:
        error_message = response.json()['error']['message']
        return SearchResult(error_message)
    result = SearchResult()
    for line in response.iter_lines(decode_unicode=True):
        result.phrases.append(Phrase.parse(line))
    return result
