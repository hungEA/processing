import psycopg2

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

cursor = conn.cursor()
cursor.execute('CREATE USER ipno')
cursor.execute(open("../dvc/sql/be_schema.sql", "r").read())

cursor.close()

#Closing the connection
conn.close()
