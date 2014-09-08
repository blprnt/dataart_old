# mongoengine database module
from mongoengine import *
from flask.ext.mongoengine.wtf import model_form

from datetime import datetime
import logging

	
class Flora(Document):
	#if you leave the max_lnegth off it is a text area, turn it on and you have an input
	
	point = GeoPointField()
	near = StringField(max_length=100)
	# Category is a list of Strings
	species = StringField(max_length=50)

	# Timestamp 
	timestamp = DateTimeField(default=datetime.now())










