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


print(os.environ.get('POSTGRES_DB'))
print(os.environ.get('POSTGRES_USER'))
print(os.environ.get('POSTGRES_PASSWORD'))
print(os.environ.get('POSTGRES_HOST', 'localhost'))
print(os.environ.get('POSTGRES_PORT', '5432'))

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
cursor.execute("select version()")

# Fetch a single row using fetchone() method.
data = cursor.fetchone()
print("Connection established to: ", data)

cursor.close()

# print(os.listdir('.'))

cursor = conn.cursor()
print('Building db schema')
# cursor.execute("CREATE USER ipno WITH PASSWORD 'ipno-P4ssWd'")
cursor.execute(open("dvc/sql/be_schema.sql", "r").read())

conn.commit()
cursor.close()
# conn.close()

# schema = pd.read_sql('''
#    SELECT table_name FROM information_schema.tables
#    WHERE table_schema = 'public'
#    ''', conn
# )
# print(schema)



# conn = psycopg2.connect(
#    database=os.environ.get('POSTGRES_DB', 'postgres'),
#    user='ipno',
#    password='ipno-P4ssWd',
#    host=os.environ.get('POSTGRES_HOST', 'localhost'),
#    port=os.environ.get('POSTGRES_PORT', '5432')
# )

import_department(conn)
import_officer(conn)
import_complaint(conn)
import_appeal(conn)
import_uof(conn)
import_citizen(conn)
import_document(conn)


#Closing the connection
conn.close()
