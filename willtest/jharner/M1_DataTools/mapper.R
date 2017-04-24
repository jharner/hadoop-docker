#! /usr/bin/env Rscript

input <- file("stdin", "r")

while( TRUE ){

	currentLine <- readLines(input, n=1)
	if( 0 == length(currentLine) ){
		break
	}

	currentFields <- unlist( strsplit(currentLine, ","))
  
	result <- paste(currentFields[2], currentFields[7], sep="\t")
	cat(result, "\n", sep = "")

}

close(input)
