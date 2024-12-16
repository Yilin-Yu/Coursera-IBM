# Task 1
mongoimport -u root -p PASSWORD --authenticationDatabase admin -d entertainment -c movies --host mongo movies.json

# Task 2
use entertainment
db.movies.aggregate([
    { $group: {_id: "$year", count: { $sum: 1 } } },
    { $sort: { count: -1} },
    { $limit: 1}
    ])

# Task 3
db.movies.countDocuments({ year: { $gt: 1999 } } )

# Task 4
db.movies.aggregate(
    [
        {
            $match: {year: 2007}
        },
        {
            $group:
            {
                _id: "$year",
                averrageVotes: { $avg: "$Votes"}
            }
        }
    ]
)

# Task 5
mongoexport -u root -p PASSWORD --authenticationDatabase admin -d entertainment -c movies -f "_id,title,year,rating,director" --type=csv -o partial_data.csv --host mongo

# Task 6
CREATE KEYSPACE entertainment WITH replication = {'class':'SimpleStrategy', 'replication_factor': 3};
describe keyspaces

# Task 7
CREATE TABLE entertainment.movies(
    id text PRIMARY KEY,
    title text,
    year text,
    rating text,
    director text
);
describe entertainment.movies
COPY entertainment.movies(id, title, year, rating, director) FROM 'partial_data.csv' WITH HEADER = TRUE AND DELIMITER = ',';

# Task 8
SELECT COUNT(*) FROM entertainment.movies;

# Task 9
CREATE INDEX on entertainment.movies(rating);

# Task 10
SELECT COUNT(*) FROM entertainment.movies WHERE rating='G';