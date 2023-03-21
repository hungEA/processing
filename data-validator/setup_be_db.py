import os
import psycopg2
# import pandas as pd

from department_importer import import_department
from officer_importer import import_officer
from complaint_importer import import_complaint
from appeal_importer import import_appeal
from uof_importer import import_uof
from citizen_importer import import_citizen
from document_importer import import_document
from event_importer import import_event


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
import_department(conn)
print('======== Importing officer ========')
import_officer(conn)
print('======== Importing complaint ========')
import_complaint(conn)
print('======== Importing appeal ========')
import_appeal(conn)
print('======== Importing use of force ========')
import_uof(conn)
print('======== Importing citizen ========')
import_citizen(conn)
print('======== Importing document ========')
import_document(conn)
print('======== Importing event ========')
import_event(conn)


#Closing the connection
conn.close()
