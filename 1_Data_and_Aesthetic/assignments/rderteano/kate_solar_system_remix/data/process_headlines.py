import json
from time import sleep

term = "sun"
process_file = "sun_headline_1913-2013.json"
output_file_name = "sun_processed.json"

def get_headline_context(term, txt):

	stopwords = ["at", "about","with", "as", "by", "the", "of", "and", "in", "on", "to", "an", "are", "is", "from", "over", "for", "but"]
	words = [w.lower().strip('.;-:,') for w in txt.split()]
	words = [w for w in words if w.strip() != ""] 
	try:
		i = words.index(term)
	except:
		return term

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
	
	return term 
				

j = json.load(open(process_file))
result = {'start_year': int(j['start_year']), 'years': []}

for year in j['years']:
	lines = []
	for doc in year['docs']:
		lines.append(get_headline_context(term, doc['headline']['main']))
	result['years'].append(lines)

f = open(output_file_name, "w")
f.write(json.dumps(result))
f.close()
