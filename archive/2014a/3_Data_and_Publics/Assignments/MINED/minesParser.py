import csv
import sys


mines = open('minedata.csv', 'rb')
csvReader = csv.reader(mines, delimiter = ',', quotechar = '"')
#writer = csv.writer(open('washington.csv', 'wb'))
input = raw_input("Types of mines in this state: ")

commodity_count = dict()
for data in csvReader:
	
	state = data[4]
	commod = data[1]
	if state == input:
		if commod in commodity_count:
			commodity_count[commod] += 1
 		else:				
 			commodity_count[commod] = 1

print commodity_count
print sum(commodity_count.values())

#for key, value in commodity_count.items():
 #	writer.writerow([key, value])