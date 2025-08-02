PASS = ''
HOST = ''

import mysql.connector
import random

connection = mysql.connector.connect(user='root', password=PASS, host=HOST, database='sales')

cursor = connection.cursor()

def get_last_rowid():
    SQL = "select max(rowid) from sales_data"
    cursor.execute(SQL)
    result = cursor.fetchall()[0][0]
    return result

def get_latest_records(rowid):
    SQL = "select * from sales_data where rowid > %s" % rowid
    cursor.execute(SQL)
    result = cursor.fetchall()
    return result

def insert_records(record):
    SQL = "insert into sales_data(rowid, product_id, customer_id, quantity) values (%s, %s, %s, %s)"
    cursor.execute(SQL, record)

rowid = get_last_rowid()


print("last rowid:", rowid)
record = (rowid+1, random.randint(5000, 6000), random.randint(500, 60000), random.randint(1, 50))
insert_records(record)
print ("lastest row after:",rowid, get_latest_records(rowid))

# close connection
connection.close()