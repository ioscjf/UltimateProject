import mysql.connector
from mysql.connector import errorcode

DB_name = "ultimate"

TABLES = {}

TABLES{"teams"} = (
	"CREATE TABLE 'teams' ("
	"'teamName' varchar(40) NOT NULL,"
	"'school' varchar(20) NOT NULL,"
	"'competition division' varhar(10) NOT NULL,"
	"'year' int(4),"
	"'state' varchar(15),"
	"'region' varchar(20),"
	"'conference' varchar(20),"
	"PRIMARY KEY ('teamName')"
	)

cnnn = mysql.connector.connect()
cur = cnx.cursor()

def create_database(cursor):
	try:
		cursoe.execute("CREATE DATABASE {} DEFAULT CHARACTER SET 'utf8'".format(DB_NAME))
	except mysql.connector.Error as err:
		print("Failed creating database: {}".format(err))
		exit(1)
