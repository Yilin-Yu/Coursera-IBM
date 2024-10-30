#!/bin/sh

## Write your code here to load the data from sales_data table in Mysql server to a sales.csv.Select the data which is not more than 4 hours old from the current time.

#Hint: To load the data from a table to a csv file you can refer to the following example syntax:
# mysql -h mysql -P 3306 -u root --password=<replace with your password> --database=<replace with your databasename> --execute="select column1,column2 from table name" --batch --silent > /path/nameofcsv

#This command connects to a MySQL server, executes a SELECT query to fetch specific columns from a specified table in a database, and saves the query results as a CSV file.

#The output options --batch: Causes MySQL to output rows with tab-separated values. This is useful for scripting.

#--silent: Suppresses the display of query output.

mysql -h mysql -P 3306 -u root --password=xxx --database=sales --execute="SELECT rowid, product_id, customer_id, price, quantity, timestamp FROM sales_data WHERE TIMESTAMPDIFF(HOUR, timestamp, CURRENT_TIMESTAMP) > 4;" --batch --silent > /home/project/sales.csv


#The csv generated will have tabs. We then replace all the tabs by commas by executing the command below:

tr '\t' ',' < /home/project/sales.csv > /home/project/temp_sales_commas.csv



# Move the temporary file with commas to the original file location
mv /home/project/temp_sales_commas.csv /home/project/sales.csv


 export PGPASSWORD=xxx;



 psql --username=postgres --host=postgres --dbname=sales_new -c "\COPY sales_data(rowid,product_id,customer_id,price,quantity,timestamp) FROM '/home/project/sales.csv' delimiter ',' csv header;" 




 ## Delete sales.csv present in location /home/project

 ## Write your code here to load the DimDate table from the data present in sales_data table


 psql --username=postgres --host=postgres --dbname=sales_new -c  "INSERT INTO dimdate(dateid, day, month, year) SELECT to_char(timestamp, 'YYYYMMDD')::integer AS dateid, EXTRACT(DAY FROM timestamp) AS day, EXTRACT(MONTH FROM timestamp) AS month, EXTRACT(YEAR FROM timestamp) AS year FROM sales_data"

## Write your code here to load the FactSales table from the data present in sales_data table


psql --username=postgres --host=postgres --dbname=sales_new -c  "INSERT INTO factsales(rowid, product_id, customer_id, price, total_price) SELECT rowid, product_id, customer_id, price, price * quantity total_price FROM sales_data"

 ## Write your code here to export DimDate table to a csv


 psql --username=postgres --host=postgres --dbname=sales_new -c "\copy (SELECT * FROM dimdate) TO '/home/project/DimDate.csv' WITH csv"

 ## Write your code here to export FactSales table to a csv
 

 psql --username=postgres --host=postgres --dbname=sales_new -c "\copy (SELECT * FROM factsales) TO '/home/project/FactSales.csv' WITH csv"

