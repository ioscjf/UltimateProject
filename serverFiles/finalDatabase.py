import pymysql

import mysql.connector
from mysql.connector import errorcode

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import sessionmaker
from sqlalchemy import PrimaryKeyConstraint, ForeignKey

#Trying to connect non-locally:
engine = create_engine("mysql+pymysql://admin:frisbee@45.55.95.100:3306/finalDatabase")

Base = declarative_base()

class Team(Base):
	#Stores info on a team. Sample entry:
	#teamID   school          teamName   conference       region             competitionDivision   genderDivision
	#123456   Luther College  LUFDA      West Plains D-I  North Central D-I  College D-I           Men
        __tablename__ = 'team'

        teamID = Column(Integer, primary_key=True)
	school = Column(String(40))
	teamName = Column(String(40))
	conference = Column(String(50))
	region = Column(String(50))
	competitionDivision = Column(String(20)) #D-I, D-III, developmental
	genderDivision = Column(String(10)) #Men's, women's, mixed

	def __repr__(self):
		return "<Team(teamID='%s', school='%s', teamName='%s', conference='%s', region='%s', competitionDivision='%s', genderDivision='%s')>" % (self.teamID, self.school, self.teamName, self.conference, self.region, self.competitionDivison, self.genderDivision)

class PlayerOnTeam(Base):
	#Stores information on which teams a player was a part of, links player and team tables. Stores playerID, a team they have played on, and which season they played on that team. A few sample entries:
	#Player ID     teamID     seasonID
	#123456        987654     2010
	#123456	       987654	  2011
	#123456	       999888     2011
	#111222        999888     2011
	#111111	       999888     2011
	__tablename__ = 'playerOnTeam'
	PrimaryKeyConstraint('playerID', 'teamID', 'seasonID')

	playerID = Column(Integer)
	teamID = Column(Integer)
	seasonID = Column(Integer)

	def __repr__(self):
		return "<PlayerOnTeam(playerID='%s', teamID='%s', seasonID='%s')>" % (self.playerID, self.teamID, self.seasonID)

class Player(Base):
	#Stores information on a player. Sample entry:
	#playerID   nameFirst   nameLast   age   position   height   weight   jerseyNum
	#123456     Joe         Schmoe     21    Cutter     73       160      8
        __tablename__ = "player"

	playerID = Column(Integer, primary_key=True)
	nameFirst = Column(String(20))
	nameLast = Column(String(20))
	age = Column(Integer)
	position = Column(String(10))
	height = Column(Integer) #Height in inches, can display feet and inches and convert after reading/before writing
	weight = Column(Integer) #Weight in pounds
	jerseyNum = Column(Integer)

	def __repr(self):
		return "<Player(playerID='%s', nameFirst='%s', nameLast='%s', age='%s', position='%s', height='%s', weight='%s', jerseyNum='%s')>" % (self.playerID, self.nameFirst, self.nameLast, self.age, self.position, self.height, self.weight, self.jerseyNum)

class Games(base):
	#Stores information about a game from the perspective of the team that recorded it. Sample table:
	#gameID   teamID   seasonID   month   day   tournament      gameNum   location      opponent
	#000001   998877   2015       10      14    Luther Invite   1         Decorah, IA   St. Olaf
	#000002   998877   2015       10      14    Luther Invite   2         Decorah, IA   St. John's
	__tablename__ == "games"

	gameID = Column(Integer, primary_key=True)
	teamID = Column(Integer) #TeamID of the team that recorded the game
	seasonID = Column(Integer) #Season the game occurred in
	month = Column(Integer) #Stored as an int, convert to string name of month when reading
	day = Column(Integer) #Day the game took place on
	tournament = Column(String(40)) #Tournament the game was played at
	gameNum = Column(Integer) #Number of the game at the tournament- First game would be 1, second would be 2, etc
	location = Column(String(40)) #Location of the tournament
	opponent = Column(String(40)) #Not tied to a team ID, but more of a reminder for the team of who they played

	def __repr__(self)
		return "<Game(gameID='%s', teamID='%s', seasonID='%s', month='%s', day='%s', tournament='%s', gameNum='%s', location='%s', opponent='%s')>" % (self.gameID, self.teamID, self.seasonID, self.month, self.day, self.tournament, self.gameNum, self.location, self.opponent)

class GamePlayers(Base):
	#Links players and games tables, gives info on which players played in which games
	#gameID   playerID
	#000001   123456
	#000001   987654
	#000001	  998877
	__tablename__ = "gamePlayers"
	PrimaryKeyConstraint('gameID', 'playerID')

	gameID = Column(Integer)
	playerID = Column(player)

	def __repr__(self):
		return "<GamePlayer(gameID='%s', playerID='%s')>" % (self.gameID, self.playerID)

class Stats(Base):
	#Stores a player's statline from a certain game
	#playerID   gameID   scores   assists   completions   throwingErrors   drops   ds   goallineThrowingErrors   goallineDrops    goallineDs   fouls   pulls   pullsOutOfBounds   offensivePointsPlayed   defensivePointsPlayed
	#123456     998877   7        2         10            3                0       2    1                        0                 2           2       4       0                  5                       6
	#123456     887766   2        4         18            4                1       6    2                        1                 0           0       8       1                  2                       4
        __tablename__ = "stats"
	PrimaryKeyConstraint('playerID', 'gameID')

        playerID = Column(Integer, primary_key=True)
	gameID = Column(Integer)
	scores = Column(Integer) #Number of times player scored in the game
	assists = Column(Integer) #Number of assists recorded
	completions = Column(Integer) #Number of completed passes thrown
	throwingErrors = Column(Integer) #Number of incomplete passes throw/throwaways
	drops = Column(Integer) #Number of drops
	ds = Column(Integer) #Number of turnovers forced on defense
	goallineThrowingErrors = Column(Integer) #Number of incomplete passes/throwaways near goal line
	goallineDrops = Column(Integer) #Number of drops near goal line
	goallineDs = Column(Integer) #Number of turnovers forced on defence near goal line
	fouls = Column(Integer) #Number of fouls committed
	pulls = Column(Integer) #Number of pulls thrown
	pullsOutOfBounds = Column(Integer) #Number of pulls thrown out of bounds
	offensivePointsPlayed = Column(Integer) #Number of total points played starting on offense
	defensivePointsPlayed = Column(Integer) #Number of total points platyed starting on defense

        def __repr__(self):
                return "<Stats(playerID='%s', gameID='%s', scores='%s',  assists='%s', completions='%s', throwingErrors='%s', drops='%s', ds='%s', goallineTThrowingErrors='%s', goallineDrops='%s', goallineDs='%s', fouls='%s', pulls='%s', pullsOutOfBounds='%s', offensivePointsPlayed='%s', defensivePointsPlayed='%s')>" % (self.playerID, self.gameID, self.scores, self.assists,self.completions, self.throwingErrors, self.drops, self.ds, self.goallineThrowingErrors, self.goallineDrops, self.goallineDs, self.fouls, self.pulls, self.pullsOutOfBounds, self.offensivePointsPlayed, self.defensivePointsPlayed)

Base.metadata.create_all(engine)
Session = sessionmaker()
Session.configure(bind=engine)
session = Session()

#Helper methods/functions with tables
def isEmpty(table):
        if len(session.query(table).all()) == 0:
                return True
        else:
                return False

def addTeam(teamID, school, teamName, conference, region, competitionDivision, genderDivision):
        if engine.dialect.has_table(engine.connect(), "Team"):
                newTeam = Team(teamID=teamID, school=school, teamName=teamName, conference=conference, region=region, competitionDivision=competitionDivision, genderDivision=genderDivision)
                session.add(newTeam)
                session.commit()

def addPlayerOnTeam(playerID, teamID, seasonID):
	if engine.dialect.has_table(engine.connect(), "PlayerOnTeam"):
		newEntry = PlayerOnTeam(playerID=playerID, teamID=teamID, seasonID=seasonID)
		session.add(newEntry)
		session.commit()

def addPlayer(playerID, nameFirst, nameLast, age, position, height, weight, jerseyNum):
        if engine.dialect.has_table(engine.connect(), "Player"):
                newPlayer = Player(playerID=playerId, nameFirst=nameFirst, nameLast=nameLast, age=age, position=position, height=height, weight=weight, jerseyNum=jerseyNum)
                session.add(newPlayer)
                session.commit()

def addGame(gameID, teamID, seasonID, month, day, tournament, gameNum, location, opponent):
	if engine.dialect.has_table(engine.connect(), "Game"):
		newGame = Game(gameID=gameID, teamID=teamID, seasonID=seasonID, month=month, day=day, tournament=tournament, gameNum=gameNum, location=location, opponent=opponent)
		session.add(newGame)
		session.commit()

def addGamePlayers(gameID, playerID):
	if engine.dialect.has_table(engine.connect(), "GamePlayers"):
		newEntry = GamePlayers(gameID=gameID, playerID=playerID)
		session.add(newEntry)
		session.commit()

def addStats(playerID, gameID, scores, assists, completions, throwingErrors, drops, ds, goallineThrowingErrors, goallineDrops, goallineDs, fouls, pulls, pullsOutOfBounds, offensivePointsPlayed, defensivePointsPlayed):
        if engine.dialect.has_table(engine.connect(), "Stats"):
                statLine = Stats(playerID=playerID, gameID=gameID, scores=scores, assists=assists, completions=completions, throwingErrors=throwingErrors, drops=drops, ds=ds, goallineThrowingErrors=goallineThrowingErrors, goallineDrops=goallineDrops, goallineDs=goallineDs, fouls=fouls, pulls=pulls, pullsOutOfBounds=pullsOutOfBounds, offensivePointsPlayed=offensivePointsPlayed, defensivePointsPlayed=defensivePointsPlayed)
                session.add(statLine)
                session.commit()

def getData(table): #Given the name of a table, returns all the items in the table
        retStr = ""
        if table == "Team":
                for instance in session.query(Team):
                        retStr += "Team:\n"
			retStr += "     " + "School: " + instance.school + "\n"
                        retStr += "     " + "Team name: " + instance.teamName + "\n"
                        retStr += "     " + "Conference: " + instance.conference + "\n"
                        retStr += "     " + "Region: " + instance.region + "\n"
                        retStr += "     " + "Competition division: " + instance.competitionDivision + "\n"
                        retStr += "     " + "Gender division: " + instance.genderDivision + "\n"
                retStr = retStr[:-1] #Removes last unnecessary newline character
        elif table == "Player":
                for instance in session.query(Player):
                        retStr += "Player:\n"
                        retStr += "     " + "Player name (first): " + instance.nameFirst + "\n"
                        retStr += "     " + "Player name (last): " + instance.nameLast + "\n"
                        retStr += "     " + "Age: " + str(instance.age) + "\n"
                        retStr += "     " + "Position: " + instance.position + "\n"
                        retStr += "     " + "Height: " + instance.height + "\n"
                        retStr += "     " + "Weight: " + instance.weight + "\n"
                        retStr += "     " + "Jersey number: " + str(instance.jerseyNum) + "\n"
                retStr = retStr[:-1] #Removes last unnecessary newline character

#Left off here- Edit the following getData elif statements.....
        elif table == "Stats":
                for instance in session.query(Stats):
                        retStr += "Stats:\n"
                        retStr += "     " + "Player name: " + instance.playerName + "\n"
                        retStr += "     " + "Year: " + str(instance.year) + "\n"
                        retStr += "     " + "Scores: " + str(instance.scores) + "\n"
                        retStr += "     " + "Assists: " + str(instance.assists) + "\n"
                        retStr += "     " + "Offensive points played: " + str(instance.offensivePointsPlayed) + "\n"
                        retStr += "     " + "Defensive points played: " + str(instance.defensivePointsPlayed) + "\n"
                        retStr += "     " + "Drops: " + str(instance.drops) + "\n"
                        retStr += "     " + "Catches: " + str(instance.catches) + "\n"
                        retStr += "     " + "Completions: " + str(instance.completions) + "\n"
                retStr = retStr[:-1] #Removes last unnecessary newline character
        else:
                retStr += "No data"
        return retStr

def testEmptiness():
        #Adding dummy data if creating db for first time
        if isEmpty(Team):
                if engine.dialect.has_table(engine.connect(), "team"):
                        testTeam = Team(teamName="Test", school="Testing University", competitionDivision="D-I", year=2016,
                                state="IA", region="MW", conference="Conference 1")
                        session.add(testTeam)
                        testTeam2 = Team(teamName="2nd test", school="UT", competitionDivision="D-III", year=2016,
                                state="IA", region="MW", conference="Conference 2")
                        session.add(testTeam2)
                        session.commit()
        if isEmpty(Player):
                if engine.dialect.has_table(engine.connect(), "player"):
                        player1 = Player(playerName="Bob Random", position="Cutter", age=21, height="6 feet 2 inches", school="Luther", jerseyNum=10)
                        session.add(player1)
                        player2 = Player(playerName="Joe Schmoe", position="Handler", age=20, height="5 feet 10 inches", school="Minnesota", jerseyNum=5)
                        session.add(player2)
        if isEmpty(Stats):
                if engine.dialect.has_table(engine.connect(), "stats"):
                        print("Check")
                        statLine = Stats(playerName="Test Player", year=2015, scores=23, assists=12, offensivePointsPlayed=31,
                                defensivePointsPlayed=15, drops=4, catches=27, completions=18)
                        session.add(statLine)
                        session.commit()
def main():
        testEmptiness()
        print(getData("Team"))
        print(getData("Player"))
        print(getData("Stats"))

main()
