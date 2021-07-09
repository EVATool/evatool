// TODO Revert tables to their 0 entry state wihtout changing anything else
// Delete database and flyway volumes and restart backend? Does that clear all data without chaning anything else?
docker-compose down
TODO "delete * from analysis"
TODO "delete * from flyway_???"
docker-compose up -d
