import os, datetime
import re
from flask import Flask, request, render_template, redirect, abort, flash, json

from unidecode import unidecode

# mongoengine database module
from flask.ext.mongoengine import MongoEngine


app = Flask(__name__)   # create our flask app
#app.config['CSRF_ENABLED'] = False
#app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY')



# --------- Database Connection ---------
# MongoDB connection to MongoLab's database
app.config['MONGODB_SETTINGS'] = {'HOST':os.environ.get('MONGOLAB_URI'),'DB': 'GowanusFlora'}
app.logger.debug("Connecting to MongoLabs")
db = MongoEngine(app) # connect MongoEngine with Flask App

# import data models
import models


# hardcoded categories for the checkboxes on the form
species = ['Wild Madder', 'Mugwort', 'Lambs Quarters', 'Shepherds Purse', 'Storksbill', 'White Clover', 'Bittersweet Nightshade', 'Black Medick', 
'Rough Fruitted Cinquefoil', 'Common Groundsel', 'Garlic Mustard']

# Plant Info Catalog
SOLplants = {}
SOLplants['Red Maple']= {
	'thumb':'sm_redmaple.jpg',
	'image':'lg_redmaple.jpg',
	'latin':'Acer Rubrum',
	'aka': ['Swamp Maple', 'Soft Maple'],
	'characteristics': [
	'3 lobes (occasionally 5) in palmate arrangement', 
	'Closely toothed edges with sharp v-shaped shallow sinuses (indentations)',
	'Flowers appear before leaves',
	'Red buds and twigs',
	'Samaras (seed pods) are small (less than 1 inch)'
	],
	'native':'Gowanus',
	'facts': ['Early settlers made ink and dye from the bark.', 'It is the most common variety of tree in North America.']
}
SOLplants['Norway Maple']={
	'thumb':'sm_norwaymaple.jpg',
	'image':'lg_norwaymaple.jpg',
	'latin':'Acer platanoides',
	'aka':[''],
	'characteristics':[
	'5 lobes in palmate arrangement',
	'Smoothed edges or very few teeth with rounded sinuses (indentations)',
	'Some variations have purple leaves',
	'Red or green buds',
	'Stout and blunt petiole',
	'Milky sap'
	],
	'native':'Europe and Southwest Asia',
	'facts':['It is possibly the most common street tree in eastern cities.', 'It was introduced as an ornamental species.']	
}
SOLplants['Silver Maple']={
	'thumb':'sm_silvermaple.jpg',
	'image':'lg_silvermaple.jpg',
	'latin':'Acer saccharinum',
	'aka':['Creek Maple', 'Silverleaf Maple', 'Water Maple'],
	'characteristics':[
	'5 lobes in palmate arrangement',
	'6 inch leaves',
	'Closely toothed edges with sharp v-shaped deep sinuses (indentations)',
	'2 inch samaras'
	],
	'native':'Gowanus',
	'facts':['It is too big to be a street tree and should only be planted in parks.', 'It was introduced as an ornamental species.']

}

SOHplants = {}

SOHplants['Catalpa']={
	'thumb':'sm_catalpa.jpg',
	'image':'lg_catalpa.jpg',
	'latin':'Catalpa Scopoli',
	'aka':[],
	'characteristics':[
	'Large heart-shaped to three-lobed leaves',
	'White or yellow flowers in broad panicles in the autumn',
	'Long fruits, which resemble a slender string bean'
	],
	'native':'Gowanus',
	'facts':['']

}

SOHplants['Paulownia']={
	'thumb':'sm_paulownia.jpg',
	'image':'lg_paulownia.jpg',
	'latin':'Paulownia tomentosa',
	'aka':['Empress Tree','Princess Tree', 'Foxglove Tree'],
	'characteristics':[
	'Large heart shaped leaves',
	'6-16 inch leaves',
	'Purple flowers resemble a foxglove flower',
	'Fruit is a dry egg-shaped containing numerous tiny seeds '
	],
	'native':'China - Invasive in the US',
	'facts':['']

}

SOSplants = {}

SOSplants['Buckthorn']={
	'thumb':'sm_buckthorn.jpg',
	'image':'lg_buckthorn.jpg',
	'latin':'Rhamnus cathartica',
	'aka':[],
	'characteristics':[
	'Egg-shaped leavea pointed at the tip', 
	'Leaves are smooth dark glossy and finely-toothed',
	'3-5 pair of curved leaf veins',
	'Twigs often end in small (<1/4") sharp stout thorns',
	'Large, round, berry-like clusters of 1/4" fruit in August/September'
	],
	'native':'North and South America - Invasive to Gowanus',
	'facts':['']

}

SASplants = {}

SASplants['Bayberry']={
	'thumb':'sm_bayberry.jpg',
	'image':'lg_bayberry.jpg',
	'latin':'Myrica cerifera',
	'aka':['Southern Wax Myrtle', 'Candleberry', 'Tallow shrub'],
	'characteristics':[
	'Long ovate simple leaves are toothed towards tip', 
	'Large shrub or small tree thrives near water',
	'Small clusters of waxy grey-blue berries arranged alternately along branches'
	],
	'native':'Gowanus',
	'facts':['']

}

COSplants ={}
COSplants['Silk Tree']={
	'thumb':'sm_silktree.jpg',
	'image':'lg_silktree.jpg',
	'latin':'Albizia julibrissin',
	'aka':['Persian Silk Tree', 'Pink Silk Tree', 'Mimosa'],
	'characteristics':[
	'Showy and fragrant pink flowers that resemble pom- poms',
	'Fruits are flat, straw-colored 6" leguminous pods containing oval-shaped seeds',
	'Bark is dark greenish grey in colour and striped vertically as it gets older',
	'Fern-like leaves, finely divided, 5-8 inches long by about 3-4 inches wide, arranged oppositely along stems'
	],
	'native':'Asia - Introduced to US as Ornamental Species',
	'facts':['The highly scented fruit of bayberry was a source of wax for early settlers in America.']

}



# --------- Routes ----------
# this is our main pagex
@app.route("/", methods=['GET','POST'])
def index():
	return render_template("main.html")
# this is our report page
@app.route("/report/<plant>", methods=['GET','POST'])
def report(plant):


	# if form was submitted and it is valid...
	if request.method == "POST":

		# get form data - create new user
		flora = models.Flora()
		
	
		flora.point = [float(request.form.get('lon')), float(request.form.get('lat'))]
		flora.near = request.form.get('near')
	
		flora.species = plant

		flora.save() # save it

		# redirect to the report list
		return redirect('/allflora')
		

	else:

		# render the template
		templateData = {
		'flora' : models.Flora.objects(),
		'species' : species,
		'plant':plant
		
		}
		return render_template("report.html", **templateData)

@app.route("/allflora")
def allflora():

	templateData = {
		'flora' : models.Flora.objects()
		}
	return render_template('allflora.html', **templateData)
#__________________________________________________________________

# this is our main pagex
@app.route("/catalog")
def catalog():

	# render and return the template
	return render_template('catalog.html', SOLplants=SOLplants, SOHplants=SOHplants, SOSplants=SOSplants, SASplants=SASplants, COSplants=COSplants)

###################################
@app.route("/flora/<flora_id>")
def solution_display(flora_id):

	# get flora by id
	try:
		flora = models.Flora.objects.get(id=flora_id)
	except:
		abort(404)

	# prepare template data
	templateData = {
		'flora' : flora,
		'species' : species,
	
		}

	# render and return the template
	return render_template('singleflora.html', **templateData)


####################################
from flask import jsonify

@app.route('/data/flora')
def data_flora():
 
	# query for the users - return oldest first, limit 10
	flora = models.Flora.objects().order_by('-timestamp')
 
	if flora:
 
		# list to hold users
		public_flora = []
 
		#prep data for json
		for f in flora:
			
			tmpFlora= {
				'type':'feature',
				'properties' :{
				
				
				'species':f.species,
				
				'reported' : str( f.timestamp )
				},
				'geometry':{
				'type': 'point',
				'coordinates' : f.point
				}
				
				
			}
 
 
			# insert user dictionary into public_users list
			public_flora.append( tmpFlora )
 
		# prepare dictionary for JSON return
		data = {
			
			'flora' : public_flora
		}
 
		# jsonify (imported from Flask above)
		# will convert 'data' dictionary and set mime type to 'application/json'
		return jsonify(data)
 
	else:
		error = {
			'status' : 'error',
			'msg' : 'unable to retrieve species list'
		}
		return jsonify(error)


####################################

@app.errorhandler(404)
def page_not_found(error):
	return render_template('404.html'), 404


# slugify the title 
# via http://flask.pocoo.org/snippets/5/
_punct_re = re.compile(r'[\t !"#$%&\'()*\-/<=>?@\[\\\]^_`{|},.]+')
def slugify(text, delim=u'-'):
	"""Generates an ASCII-only slug."""
	result = []
	for word in _punct_re.split(text.lower()):
		result.extend(unidecode(word).split())
		return unicode(delim.join(result))



# --------- Server On ----------
# start the webserver
if __name__ == "__main__":
	app.debug = True
	
	port = int(os.environ.get('PORT', 5000)) # locally PORT 5000, Heroku will assign its own port
	app.run(host='0.0.0.0', port=port)



	