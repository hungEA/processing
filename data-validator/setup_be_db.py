import os
import psycopg2
import pandas as pd

from department_importer import import_department, AGENCY_COLS
from officer_importer import import_officer, OFFICER_COLS
from complaint_importer import import_complaint, COMPLAINT_COLS
from appeal_importer import import_appeal, APPEAL_COLS
from uof_importer import import_uof, UOF_COLS
from citizen_importer import import_citizen, CITIZEN_COLS
from document_importer import import_document
from event_importer import import_event, EVENT_COLS
from person_importer import import_person, PERSON_COLS


#establishing the connection
print("Connecting to postgres...")
conn = psycopg2.connect(
   database=os.environ.get('POSTGRES_DB'),
   user=os.environ.get('POSTGRES_USER'),
   password=os.environ.get('POSTGRES_PASSWORD'),
   host=os.environ.get('POSTGRES_HOST', 'localhost'),
   port=os.environ.get('POSTGRES_PORT', '5432')
)
#Creating a cursor object using the cursor() method
cursor = conn.cursor()

#Executing an MYSQL function using the execute() method
cursor.execute("SELECT version()")

# Fetch a single row using fetchone() method.
data = cursor.fetchone()
print("Connection established to: ", data)

cursor.close()

cursor = conn.cursor()
print('Building schema of BE Database')
cursor.execute(open("dvc/sql/be_schema.sql", "r").read())

conn.commit()
cursor.close()

# schema = pd.read_sql('''
#    SELECT table_name FROM information_schema.tables
#    WHERE table_schema = 'public'
#    ''', conn
# )
# print(schema)

print('======== Importing department ========')
agency_df = pd.read_csv(
   os.path.join(os.environ.get('DATA_DIR'), 'agency_reference_list.csv')
)
columns = agency_df.columns
if not set(AGENCY_COLS).issubset(set(columns)):
   raise Exception('BE agency columns are not recognized in the current commit')

import_department(conn)

print('======== Importing officer ========')
personnel_df = pd.read_csv(
   os.path.join(os.environ.get('DATA_DIR'), 'personnel.csv')
)
columns = personnel_df.columns
if not set(OFFICER_COLS).issubset(set(columns)):
   raise Exception('BE officers columns are not recognized in the current commit')

import_officer(conn)

print('======== Importing complaint ========')
allegation_df = pd.read_csv(
   os.path.join(os.environ.get('DATA_DIR'), 'allegation.csv')
)
columns = allegation_df.columns
if not set(COMPLAINT_COLS).issubset(set(columns)):
   raise Exception('BE complaints columns are not recognized in the current commit')

import_complaint(conn)

print('======== Importing appeal ========')
appeals_df = pd.read_csv(
   os.path.join(os.environ.get('DATA_DIR'), 'appeals.csv')
)
columns = appeals_df.columns
if not set(APPEAL_COLS).issubset(set(columns)):
   raise Exception('BE appeals columns are not recognized in the current commit')

import_appeal(conn)

print('======== Importing use of force ========')
uof_df = pd.read_csv(
   os.path.join(os.environ.get('DATA_DIR'), 'use_of_force.csv')
)
columns = uof_df.columns
if not set(UOF_COLS).issubset(set(columns)):
   raise Exception('BE use-of-force columns are not recognized in the current commit')

import_uof(conn)

print('======== Importing citizen ========')
citizens_df = pd.read_csv(
   os.path.join(os.environ.get('DATA_DIR'), 'citizens.csv')
)
columns = citizens_df.columns
if not set(CITIZEN_COLS).issubset(set(columns)):
   raise Exception('BE citizens columns are not recognized in the current commit')

import_citizen(conn)

print('======== Importing event ========')
event_df = pd.read_csv(
   os.path.join(os.environ.get('DATA_DIR'), 'event.csv')
)
columns = event_df.columns
if not set(EVENT_COLS).issubset(set(columns)):
   raise Exception('BE event columns are not recognized in the current commit')

import_event(conn)

print('======== Importing person ========')
person_df = pd.read_csv(
   os.path.join(os.environ.get('DATA_DIR'), 'person.csv')
)
columns = person_df.columns
if not set(PERSON_COLS).issubset(set(columns)):
   raise Exception('BE person columns are not recognized in the current commit')

import_person(conn)

print('======== Importing document ========')
import_document(conn)

#Closing the connection
conn.close()
