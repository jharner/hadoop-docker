## RPostgresql

The following sample code shows the basics of connecting to the database. Always be sure to disconnect.

	> library(RPostgreSQL)
	Loading required package: DBI
	> mydrv <- dbDriver("PostgreSQL")
	> mycon <- dbConnect(mydrv, host="postgres", dbname="rstudio")
	> mydata <- dbGetQuery(mycon, "select 1")
	> mydata[1]
	  ?column?
	1        1
	> mydata <- dbGetQuery(mycon, "select 2")
	> mydata[1]
	  ?column?
	1        2
	> dbDisconnect(mycon)
	[1] TRUE

## HBase

	library(rhbase)
	hb.init(host = 'hbase')
	
