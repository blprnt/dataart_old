import json
from time import sleep

def get_cocaine_context(txt):

	stopwords = ["with", "as", "by", "the", "of", "and", "in", "on", "to", "an", "are", "is", "from", "over", "for", "but"]
	words = [w.lower().strip('.;-:,') for w in txt.split()]
	words = [w for w in words if w.strip() != ""] 
	try:
		i = words.index('cocaine')
	except:
		return "cocaine"

	if i+1 < len(words):
		if words[i+1] not in stopwords:
			return words[i] + " "+ words[i + 1]
		elif i+2 < len(words):
				return " ".join(words[i:i+3])
	if i-1 >= 0:
		if words[i-1] not in stopwords:
			return words[i-1] + " "+ words[i]
		elif i-2 >= 0:
			return " ".join(words[i-2:i+1])
	
	return "cocaine" 
				

j = json.load(open("cocaine_1900-2013.json"))
result = {'start_year': int(j['start_year']), 'years': []}

for year in j['years']:
	lines = []
	for doc in year['docs']:
		lines.append(get_cocaine_context(doc['headline']['main']))
	result['years'].append(lines)

f = open("cocaine_processed.json","w")
f.write(json.dumps(result))
f.close()
