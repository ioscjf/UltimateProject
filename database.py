import mysql.connector
from mysql.connector import errorcode

DB_name = "ultimate"

TABLES = {}

#Don't know if not null is needed after most entries
TABLES["teams"] = (
	"CREATE TABLE 'teams' ("
	"'teamName' varchar(40) NOT NULL,"
	"'school' varchar(20) NOT NULL,"
	"'competition division' varchar(10) NOT NULL,"
	"'year' int(4),"
	"'state' varchar(15),"
	"'region' varchar(20),"
	"'conference' varchar(20),"
	"PRIMARY KEY ('teamName')"
	)

TABLES["players"] = (
	"CREATE TABLE 'players' ("
	"'playername' varchar(30) NOT NULL,"
	"'position' varchar(10) NOT NULL,"
	"'age' int NOT NULL,"
	"'height' varchar(10) NOT NULL,"
	"'school' varchar(30) NOT NULL,"
	"'jerseyNum' int NOT NULL,"
	"'bio' varchar(500) NOT NULL,"
	"PRIMARY KEY ('playername')"
	)

TABLES["stats"] = (
	"CREATE TABLE 'stats' ("
	"'playername' varchar(30) NOT NULL,"
	"'points' int NOT NULL,"
	"'assists' int NOT NULL,"
	"'defensive plays' int NOT NULL,"
	"'drops' int NOT NULL,"
	"'points played' int NOT NULL,"
	"'offensive points played' int NOT NULL,"
	"'defensive points played' int NOT NULL,"
	"'conference' varchar(20) NOT NULL,"
	"PRIMARY KEY ('playername')"
	)

cnx = mysql.connector.connect(user ='root', password= 'p', host = '127.0.0.1', port='43053', database='ultimate')
cursor = cnx.cursor()

def create_database(cursor):
	try:
		cursor.execute("CREATE DATABASE {} DEFAULT CHARACTER SET 'utf8'".format(DB_NAME))
	except mysql.connector.Error as err:
		print("Failed creating database: {}".format(err))
		exit(1)

def main():
	create_database(cursor)

main()