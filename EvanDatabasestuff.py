import mysql.connector
from mysql.connector import errorcode

DB_name = "ultimate"

STATISTICS = {}

TABLES{"stats"} = (
	"CREATE TABLE 'stats' ("
	"'playername' varchar(30) NOT NULL,"
	"'points' int() NOT NULL,"
	"'assists' int() NOT NULL,"
	"'defensive plays' int NOT NULL,"
	"'drops' int() NOT NULL,"
	"'points played' int(4) NOT NULL,"
	"'offensive points played' int() NOT NULL,"
	"'defensive points played' int() NOT NULL,"
	"PRIMARY KEY ('playername')"
	)
