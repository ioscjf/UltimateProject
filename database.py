import mysql.connector
from mysql.connector import errorcode

DB_name = "ultimate"

TABLES = {}

TABLES{"teams"} = (
	"CREATE TABLE 'teams' ("
	"'teamName' varchar(20) NOT NULL,"
	"'school' varchar(20) NOT NULL,"
	)