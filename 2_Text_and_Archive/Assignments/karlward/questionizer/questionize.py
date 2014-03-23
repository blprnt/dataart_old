#!/usr/bin/env python

from argparse import ArgumentParser
import nltk
from parsezilla import Token, TokenList, TokenUtil
from re import search, sub, MULTILINE
from sys import exit

# functions

def register_token(s):
    t = Token(s)
    if t.token in all_tokens:
        pass
    else:
        all_tokens[t.token] = t.pron()

def find_match(target, source):
    pass


# program

parser = ArgumentParser(description='replace target file questions with source file questions')
parser.add_argument('--source', type=file, nargs=1, help='file name of file to scan for questions')
parser.add_argument('--target', type=file, nargs=1, help='file name of file to fill in with source questions')

args = parser.parse_args()

source_str = ''
for source_line in args.source[0]:
    source_str += source_line
args.source[0].close()

target_str = ''
for target_line in args.target[0]:
    target_str += target_line
args.target[0].close()

sent_tokenizer = nltk.data.load('tokenizers/punkt/english.pickle')
source_sentences = sent_tokenizer.tokenize(source_str)
source_questions = []
for sent in source_sentences:
    if search('\?(\s*|"*)$', sent, MULTILINE):
        source_questions.append(sub('\n', '', sent, MULTILINE))

target_sentences = sent_tokenizer.tokenize(target_str)
wait_for_answer = False
for sent in target_sentences:
    #print ">>> " + sent + " <<<"
    if search('\?(\s*|"*)$', sent, MULTILINE) and wait_for_answer == False:
        try:
            print '\nQ: ' + source_questions.pop(0) + '\n' + 'A: ',
            wait_for_answer = True
        except IndexError:
            exit(0)
    else:
        wait_for_answer = False
        print sent

