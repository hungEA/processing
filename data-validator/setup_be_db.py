import os
import psycopg2

from department_importer import import_department
from officer_importer import import_officer

#establishing the connection
print("Connecting to postgres...")
conn = psycopg2.connect(
   database="postgres", user='postgres', password='postgres', host='localhost', port= '5432'
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
cursor.execute("CREATE USER ipno WITH PASSWORD 'postgres'")
cursor.execute(open("dvc/sql/be_schema.sql", "r").read())

conn.commit()
cursor.close()
conn.close()

conn = psycopg2.connect(
   database="postgres", user='ipno', password='postgres', host='localhost', port= '5432'
)

import_department(conn)
import_officer(conn)


#Closing the connection
conn.close()
