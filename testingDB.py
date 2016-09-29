#Create a few new tables- Sport, team, player, player stats, etc
	#Create relationships between the tables and start messing around with them

from flask import Flask, request, jsonify, render_template, redirect
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import relationship
from sqlalchemy import PrimaryKeyConstraint, ForeignKey
from flask_bootstrap import Bootstrap

app = Flask(__name__)
app.debug = True

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///mainDB.db'
#app.config['SQLALCHEMY_BINDS'] = {
#  'mainDB': 'sqlite:///mainDB.db', #Add additional tables to this later on
#}

db = SQLAlchemy(app)
Bootstrap(app)

class MainDB(db.Model):
	__tablename__ = 'mainDB'
#	__table_args__ = ( PrimaryKeyConstraint('playerID'), ) #This line only needed if
									#primary key should be multiple fields
#	__bind_key__ = 'mainDB' #Only needed for additional tables
	playerID = db.Column(db.Integer, primary_key=True)
	position = db.Column(db.String)
	height = db.Column(db.Integer)

db.create_all() #Creates all tables

results = MainDB.query.all()
if len(results) == 0: #Add info into table if the table is empty
	#This data just examples to get some info into the db
	aPlayer = MainDB(playerID=123456, position="Cutter", height=72)
	db.session.add(aPlayer)
	aPlayer = MainDB(playerID=987654, position="Handler", height=70)
	db.session.add(aPlayer)
	aPlayer = MainDB(playerID=135246, position="Cutter", height=74)
	db.session.add(aPlayer)

db.session.commit()

if __name__ == "__main__":
	results = MainDB.query.all()
	for aPlayer in results:
		print("Player ID:", aPlayer.playerID, "   Position:", aPlayer.position, "   Height:", aPlayer.height//12,
			"feet,", aPlayer.height%12, "inches")