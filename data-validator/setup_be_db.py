import os
import psycopg2

from department_importer import import_department
from officer_importer import import_officer
from complaint_importer import import_complaint
from appeal_importer import import_appeal
from uof_importer import import_uof
from citizen_importer import import_citizen

#establishing the connection
print("Connecting to postgres...")
conn = psycopg2.connect(
   database=os.environ.get('POSTGRES_DB', 'postgres'),
   user=os.environ.get('POSTGRES_USER', 'postgres'),
   password=os.environ.get('POSTGRES_PASSWORD'),
   host=os.environ.get('POSTGRES_HOST', 'localhost'),
   port=os.environ.get('POSTGRES_PORT', '5432')
)
#Creating a cursor object using the cursor() method
cursor = conn.cursor()

#Executing an MYSQL function using the execute() method
cursor.execute("select version()")

# Fetch a single row using fetchone() method.
data = cursor.fetchone()
print("Connection established to: ", data)

cursor.close()

print(os.listdir('.'))

cursor = conn.cursor()
cursor.execute("CREATE USER ipno WITH PASSWORD 'ipno-P4ssWd'")
cursor.execute(open("dvc/sql/be_schema.sql", "r").read())

conn.commit()
cursor.close()
conn.close()

conn = psycopg2.connect(
   database=os.environ.get('POSTGRES_DB', 'postgres'),
   user='ipno',
   password='ipno-P4ssWd',
   host=os.environ.get('POSTGRES_HOST', 'localhost'),
   port=os.environ.get('POSTGRES_PORT', '5432')
)

import_department(conn)
import_officer(conn)
import_complaint(conn)
import_appeal(conn)
import_uof(conn)
import_citizen(conn)


#Closing the connection
conn.close()
