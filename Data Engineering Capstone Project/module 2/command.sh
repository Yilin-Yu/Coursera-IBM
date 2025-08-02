PASSWORD=UhEe1iO9PLHj4V1JeY4GlKp2

mongoimport --uri "mongodb://root:$PASSWORD@172.21.89.20:27017/catalog?authSource=admin" --collection electronics --file catalog.json

mongosh mongodb://root:$PASSWORD@172.21.89.20:27017
show dbs

use catalog
show collections

db.electronics.createIndex({type: 1})
db.electronics.getIndexes()

db.electronics.count({"type":"laptop"})

db.electronics.count({"type":"smart phone"}, {"screen size" : 6})

db.electronics.aggregate([
... {"$match":{"type":"smart phone"}},
... {"$group":{"_id":"$type","average":{"$avg":"$screen size"}}}])

mongoexport --uri "mongodb://root:UhEe1iO9PLHj4V1JeY4GlKp2@172.21.89.20:27017/catalog?authSource=admin" --collection electronics --type=csv --fields _id,type,model --out electronics.csv

