from utils import *
import json

term = "sun"
field = "headline"
start_year = 1913
end_year = 2013

result = get_year_range(term, field, start_year, end_year)
save_json = {
	"years" : result,
	"start_year": start_year,
	"end_year": end_year,
}
f = open("data/"+term.replace(" ","+")+"_"+field+"_"+str(start_year)+"-"+str(end_year)+".json", 'w')
f.write(json.dumps(save_json))
f.close()
print "DONE!"