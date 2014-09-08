import nltk # FIXME: from
import re # FIXME: from
import string # FIXME: from

class TokenUtil:
    @staticmethod
    def normalize(s):
        return TokenUtil.strip_punc(s).lower()

    @staticmethod
    def strip_punc(s):
        return s.translate(None, string.punctuation)

    @staticmethod
    def tokenize(s):
        return nltk.wordpunct_tokenize(TokenUtil.normalize(s))

class Token():
    pron_cache = {}

    def __init__(self, s):
        self.raw = s
        self.token = TokenUtil.normalize(s)
        self.pron_cache = None

    @classmethod
    def get_pron(cls, s):
        if cls.pron_cache.get(s, None) is not None:
            return cls.pron_cache[s]
        else:
            return None

    @classmethod
    def set_pron(cls, s, p_list):
        cls.pron_cache[s] = p_list

    def pron(self):
        if Token.get_pron(self.token) is not None: # cache hit
            return Token.get_pron(self.token)
        else:
            pronounce = nltk.corpus.cmudict.entries()
            p_list = []
            for p in pronounce:
                if p[0] == self.token:
                    p_list.append(p[1])
            Token.set_pron(self.token, p_list)
            return p_list

    def stresses(self):
        s_set = set() # set of possible stress pronunciations
        for p in self.pron():
            inside_s_list = [] # list of this variation's stresses
            for syllable in p:
                m = re.search('(\d)$', syllable)
                if m:
                    inside_s_list.append(m.group(1))
            s_set.add(','.join(inside_s_list))
        # we want to return a plain old list, not a set of sets
        s_list = []
        for item in s_set:
            i_list = []
            for item_f in item.split(','):
                i_list.append(item_f)
            s_list.append(i_list)
        if len(s_list) < 1:
            s_list.append(['0']) # FIXME: hack
        return s_list

class TokenList:
    def __init__(self, s):
        self.raw = s
        self.tokens = []
        for t_str in TokenUtil.tokenize(s):
            t_obj = Token(t_str)
            self.tokens.append(t_obj)

