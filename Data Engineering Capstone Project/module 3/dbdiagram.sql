Table softcartDimDate {
  dateid integer [primary key]
  day date
  weekday integer
  weekdayname varchar
  month integer
  monthname varchar
  quarter integer
  quartername varchar
  year year
}

Table softcartDimCategory {
  categoryid integer [primary key]
  categoryname varchar
}

Table softcartDimItem {
  itemid integer [primary key]
  itemname varchar
  price float
  categoryid integer
}

Table softcartDimCountry {
  countryid integer [primary key]
  countryname varchar
}

Table softcartFactSales {
  orderid integer [primary key]
  dateid integer [not null]
  itemid integer [not null]
  countryid integer [not null]
}

Ref: softcartDimItem.categoryid - softcartDimCategory.categoryid
Ref: softcartFactSales.dateid > softcartDimDate.dateid
Ref: softcartFactSales.itemid > softcartDimItem.itemid
Ref: softcartFactSales.countryid > softcartDimCountry.countryid

