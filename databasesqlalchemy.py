from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import sessionmaker

engine = create_engine('sqlite:///database.db', echo=False)
Base = declarative_base()

class Team(Base):
	__tablename__ = 'team'

	teamName = Column(String, primary_key=True)
	school = Column(String)
	competitionDivision = Column(String)
	year = Column(Integer)
	state = Column(String)
	region = Column(String)
	conference = Column(String)

	def __repr__(self):
		return "<Team(teamName='%s', school='%s', competitionDivision='%s', year='%s', state='%s', region='%s', conference='%s',)>" % (self.teamName, self.school, self.competitionDivision, self.year, self.state, self.region, self.conference)

#Add other tables here


Base.metadata.create_all(engine)
Session = sessionmaker()
Session.configure(bind=engine)
session = Session()

#Adding dummy data if creating db for first time
if engine.dialect.has_table(engine.connect(), "team"):
	testTeam = Team(teamName="Test", school="Testing University", competitionDivision="D-I", year=2016,
	state="IA", region="MW", conference="Conference 1")
	session.add(testTeam)
	testTeam2 = Team(teamName="2nd test", school="UT", competitionDivision="D-III", year=2016,
	state="IA", region="MW", conference="Conference 2")
	session.add(testTeam2)
	session.commit()


for instance in session.query(Team):
	print(instance.teamName, instance.school)
