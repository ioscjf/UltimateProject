import mysql.connector
from mysql.connector import errorcode

DB_name = "ultimate"

TABLES = {}


TABLES["players"] = (
        "CREATE TABLE 'players' ("
        "'name' varchar(20) NOT NULL,"
        "'school' varchar(20) NOT NULL,"
        "'jersey number' varchar(20) NOT NULL,"
        "'postion' varchar(20) NOT NULL,"
        "'height' varchar(20) NOT NULL,"
        "'weight' varchar(20) NOT NULL,"
        "'biography' varchar(100) NOT NULL,"
                )

cnnn = mysql.connector.connect()
cur = cnx.cursor()

def create_database(cursor):
	try:
		cursoe.execute("CREATE DATABASE {} DEFAULT CHARACTER SET 'utf8'".format(DB_NAME))
	except mysql.connector.Error as err:
		print("Failed creating database: {}".format(err))
		exit(1)
