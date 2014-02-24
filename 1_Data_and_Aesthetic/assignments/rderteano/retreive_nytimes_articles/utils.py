from time import sleep
from random import random
import json
import urllib2


queryDelay = 1.5
ApiKey = "YOUR API KEY HERE"


def build_query_url(term, field, year, page):
  beginn = str(year) + "0101"
  end = str(year) + "1231"
  term = term.replace(" ", "%20")
  return("http://api.nytimes.com/svc/search/v2/articlesearch.json?&fq="+field+":(%22"+term+"%22)&api-key="+ApiKey+"&begin_date="+beginn+"&end_date="+end+"&page="+str(page))

# using some extra random delay. Seems like the api knows when its being queried regularly
def random_delay():
  r = random() * 2
  sleep(queryDelay+r)


def get_complete_year(term, field, year):
  page = 0
  url = build_query_url(term, field, year, page)
  
  while True:
    try:
      obj = json.load(urllib2.urlopen(url))
      print url
      break
    except Exception as e:
      print "ERROR:", e.message
      random_delay()
      random_delay()


  meta = obj["response"]["meta"]
  hits = meta["hits"]
  result_objects = obj["response"]["docs"]

  for i in range(hits/10):
     random_delay()
     page += 1
     url = build_query_url(term, field, year, page)
     while True:
       try:
         partial = json.load(urllib2.urlopen(url))
         print url
         break
       except Exception as e:
         print "ERROR:", e.message
         random_delay()
         random_delay()
     
     partial_results = partial["response"]["docs"]
     for j in range(len(partial_results)):
         result_objects.append(partial_results[j])
     
  result = {
    "docs" : result_objects,
    "meta" : meta
  }
  return result


def get_year_range(term, field, start_year, end_year):

  result_objects = []
  for y in range(start_year, end_year + 1):
    random_delay()
    print y
    result_objects.append(get_complete_year(term, field, y))
  return result_objects




