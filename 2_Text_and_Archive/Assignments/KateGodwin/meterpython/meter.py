import nltk
from nltk.corpus import cmudict
from nltk import word_tokenize

prondict = cmudict.dict()

#
# parseStressOfLine(line) 
# function that takes a line
# parses it for stress
# corrects the cmudict bias toward 1
# and returns two strings 
#
# 'stress' in form '0101*,*110110'
#   -- 'stress' also returns words not in cmudict '0101*,*1*zeon*10110'
# 'stress_no_punct' in form '0101110110'


def parseStressOfLine(line):

    stress=""
    stress_no_punct=""
    print line

    tokens = [words.lower() for words in nltk.word_tokenize(line)] 
    for word in tokens:        

        word_punct =  strip_punctuation_stressed(word.lower())
        word = word_punct['word']
        punct = word_punct['punct']

        #print word

        if word not in prondict:
            # if word is not in dictionary
            # add it to the string that includes punctuation
            stress= stress+word
        else:
            zero_bool=True
            for s in prondict[word]:
                # oppose the cmudict bias toward 1
                # search for a zero in array returned from prondict
                # if it exists use it
                # print strip_letters(s),word
                if strip_letters(s)=="0":
                    stress = stress + "0"
                    stress_no_punct = stress_no_punct + "0"
                    zero_bool=False
                    break

            if zero_bool:
                stress = stress + strip_letters(prondict[word][0])
                stress_no_punct=stress_no_punct + strip_letters(prondict[word][0])

        if len(punct)>0:
            stress= stress+punct

    return {'stress':stress,'stress_no_punct':stress_no_punct}



# STRIP PUNCTUATION but keep it
def strip_punctuation_stressed(word):
    # define punctuations
    punctuations = '!()-[]{};:"\,<>./?@#$%^&*_~'
    my_str = word

    # remove punctuations from the string
    no_punct = ""
    punct=""
    for char in my_str:
        if char not in punctuations:
            no_punct = no_punct + char
        else:
            punct = punct+char

    return {'word':no_punct,'punct':punct}


# CONVERT the cmudict prondict into just numbers
def strip_letters(ls):
    #print "strip_letters"
    nm = ''
    for ws in ls:
        #print "ws",ws
        for ch in list(ws):
            #print "ch",ch
            if ch.isdigit():
                nm=nm+ch
                #print "ad to nm",nm, type(nm)
    return nm


# TESTING  results 
# i do not correct for the '2'

##C++
#line = """#include < i o stream>
#
# ent main()
# {
# 	stood:: c out << "Hello, World.";
# }"""
# 
#print parseStressOfLine(line)
#
##Java
#line = """public class Hello {
#  	public static void main(String []args) {
# 		System . out . print line ("Hello World");
#  	}
# }"""
#print parseStressOfLine(line)
#
##JavaScript popup
#line = """alert("Hello, World");"""
#print parseStressOfLine(line)
#
##LISP
#line = """(DE FUN HELLO - WORLD ()
#	(PRINT (LIST ' HELLO ' WORLD)))"""
#print parseStressOfLine(line)
#
##Python
#line = """print "hello world" """
#print parseStressOfLine(line)
#
##Ruby
#line = """puts "Hello, world" """
#print parseStressOfLine(line)

#The Seafarer
#line = """May I for my own self song's truth reckon,
#Journey's jargon, how I in harsh days
#Hardship endured oft.
#Bitter breast cares have I abided,
#Known on my keel many a care's hold,
#And dire sea surge, and there I oft spent
#Narrow night watch nigh the ship's head
#While she tossed close to cliffs. Coldly afflicted,
#My feet were by frost be numbed.
#Chill its chains are; chafing sighs
#Hew my heart round and hunger begot
#Mere weary mood. Lest man know not
#That he on dry land love liest live eth,
#List how I, care wretched, on ice cold sea,
#Weathered the winter, wretched outcast
#Deprived of my kin men;"""
#print parseStressOfLine(line)

#Processing
#line = """void setup() {
#    size(five hundred, five hundred);
#    print line ("hello, world");
#}
#
#void draw() {
#}"""
#print parseStressOfLine(line)

line = """float x, y, speed;

void setup() {
  size( four thirty, four thirty );
  background( thirty );
}

void draw() {
  render Pattern();
}

void render Pattern() {
  speed plus equals point o o four;

  push Matrix();
    translate( width divided by two, height divided by two );
    
    for (ent i equals zero; i less than one hundred; i plus equals five) {
      x equals sine ( ( speed plus i ) times two hundred ) times two hundred;
      y equals co sine ( speed plus i ) times two hundred;
      
      no Stroke();
      fill( two thirty, two thirty, two thirty, one thirty );
      ellipse( x, y, two, two );
    }
  pop Matrix();
}"""
print parseStressOfLine(line);


#""" 
#
#OUTPUT 
#
#This day (the year I dare not tell)
#{'stress': '01***(*011111***)*', 'stress_no_punct': '01011111'}
#Apollo play'd the midwife's part;
#{'stress': "0101*'d*01211***;*", 'stress_no_punct': '010101211'}
#Into the world Corinna fell,
#{'stress': '01012101*,*', 'stress_no_punct': '01012101'}