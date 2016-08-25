library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host="postgres", dbname='dataexpo')

meas <- dbGetQuery(con, "select * from location_table")

dbDisconnect(con)
dbUnloadDriver(drv)
rm(con)
rm(drv)
