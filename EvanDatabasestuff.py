import mysql.connector
from mysql.connector import errorcode

DB_name = "ultimate"

STATISTICS = {}

TABLES{"stats"} = (
	"CREATE TABLE 'stats' ("
	"'playername' varchar(30)"
	"'points' int() NOT NULL,"
	"'assists' int() NOT NULL,"
	"'drops' int() NOT NULL,"
	"'points played' int(4),"
	"'offensive points played' int(),"
	"'defensive points played' int(),"
	"'conference' varchar(20),"
	"PRIMARY KEY ('playername')"
	)
