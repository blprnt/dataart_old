import sys
import random

stuff = list()

for line in sys.stdin:
	line = line.strip()
	stuff.append(line)
	
slogan_a = random.choice(stuff)
slogan_b = random.choice(stuff)
slogan_c = random.choice(stuff)

#print slogan_a[:10] + slogan_b[10:]

slogan_a_words = slogan_a.split(" ")
slogan_b_words = slogan_b.split(" ")
slogan_c_words = slogan_c.split(" ")

first_part = " ".join(slogan_a_words[:4])
second_part = " ".join(slogan_b_words[4:])
third_part = " ".join(slogan_c_words[5:])

#print first_part + " " + second_part

print first_part + " " + second_part + "." + " " + third_part

#print first_part + " " + second_part
