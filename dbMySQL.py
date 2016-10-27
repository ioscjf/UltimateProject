import pymysql

import mysql.connector
from mysql.connector import errorcode

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import sessionmaker
from sqlalchemy import PrimaryKeyConstraint, ForeignKey

engine = create_engine("mysql+pymysql:///root@127.0.0.1/test")
Base = declarative_base()

class Team(Base):
        __tablename__ = 'team'

        teamName = Column(String(50), primary_key=True)
        school = Column(String(50))
        competitionDivision = Column(String(50))
        year = Column(Integer)
        state = Column(String(50))
        region = Column(String(50))
        conference = Column(String(50))

        def __repr__(self):
                return "<Team(teamName='%s', school='%s', competitionDivision='%s', year='%s', state='%s', region='%s', conference='%s')>" % (self.teamName, self.school, self.competitionDivision, self.year, self.state, self.region, self.conference)

class Player(Base):
        __tablename__ = "player"

        playerName = Column(String(50), primary_key=True)
        position = Column(String(50))
        age = Column(Integer)
        height = Column(String(50))
        school = Column(String(50))
        jerseyNum = Column(Integer)

        def __repr__(self):
                return "<Player(playerName='%s', position='%s', age='%s', height='%s', school='%s', jerseyNum='%s')>" % (self.playerName, self.position, self.age, self.height, self.school, self.jerseyNum)

class Stats(Base):
        #We will need to add functionality for the primary key to come from both the playerName and year
        __tablename__ = "stats"

        playerName = Column(String(50), primary_key=True)
        year = Column(Integer)
        scores = Column(Integer)
        assists = Column(Integer)
        offensivePointsPlayed = Column(Integer)
        defensivePointsPlayed = Column(Integer)
        drops = Column(Integer)
        catches = Column(Integer)
        completions = Column(Integer)

        def __repr__(self):
                return "<Stats(playerName='%s', year='%s', assists='%s', offensivePointsPlayed='%s', defensivePointsPlayed='%s', drops='%s', catches='%s', completions='%s')>" % (self.playerName, self.year, self.scores, self.assists, self.offensivePointsPlayed, self.defensivePointsPlayed, self.drops, self.catches, self.completions)

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

def addTeam(teamName, school, competitionDivision, year, state, region, conference):
        if engine.dialect.has_table(engine.connect(), "Team"):
                newTeam = Team(teamName=teamName, school=school, competitionDivision=competitionDivision, 
                        year=year, state=state, region=region, conference=conference)
                session.add(newTeam)
                session.commit()

def addPlayer(playerName, position, age, height, school, jerseyNum):
        if engine.dialect.has_table(engine.connect(), "Team"):
                newPlayer = Player(playerName=playerName, position=position, age=age, height=height, 
                        school=school, jerseyNum=jerseyNum)
                session.add(newPlayer)
                session.commit()

def addStats(playerName, year, scores, assists, offensivePointsPlayed, defensivePointsPlayed, drops, catches, completions):
        if engine.dialect.has_table(engine.connect(), "Stats"):
                statLine = Stats(playerName=playerName, year=year, scores=scores, assists=assists, offensivePointsPlayed=offensivePointsPlayed, 
                        defensivePointsPlayed=defensivePointsPlayed, drops=drops, catches=catches, completions=completions)
                session.add(statLine)
                session.commit()

def getData(table): #Given the name of a table, returns all the items in the table
        retStr = ""
        if table == "Team":
                for instance in session.query(Team):
                        retStr += "Team:\n"
                        retStr += "     " + "Team name: " + instance.teamName + "\n"
                        retStr += "     " + "School: " + instance.school + "\n"
                        retStr += "     " + "Competition division: " + instance.competitionDivision + "\n"
                        retStr += "     " + "Year: " + str(instance.year) + "\n"
                        retStr += "     " + "State: " + instance.state + "\n"
                        retStr += "     " + "Region: " + instance.region + "\n"
                        retStr += "     " + "Conference: " + instance.conference + "\n"
                retStr = retStr[:-1] #Removes last unnecessary newline character
        elif table == "Player":
                for instance in session.query(Player):
                        retStr += "Player:\n"
                        retStr += "     " + "Player name: " + instance.playerName + "\n"
                        retStr += "     " + "Position: " + instance.position + "\n"
                        retStr += "     " + "Age: " + str(instance.age) + "\n"
                        retStr += "     " + "Height: " + instance.height + "\n"
                        retStr += "     " + "School: " + instance.school + "\n"
                        retStr += "     " + "Jersey number: " + str(instance.jerseyNum) + "\n"
                retStr = retStr[:-1] #Removes last unnecessary newline character
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