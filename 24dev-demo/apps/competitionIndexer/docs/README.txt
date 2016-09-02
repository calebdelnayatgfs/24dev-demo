Usage: competitionIndexerCLI.sh -f [inputFile.csv] 
Example command: 
./competitionIndexerCLI.sh -f input/u07m-6yrStacks-Input.csv 

Requirements: 
- input.csv file fields: id,setid,long_ft,short_ft,row,col,block,dbh,year,site,name,optCol1,optCol2,...] 
- Bash shell 
- Postgresql database
- The program requires a comma separated CSV file (.csv)
- The first input CSV fields must include:  id,setid,long_ft,short_ft,row,col,block,dbh,year,site,name 
-- You can add other optional columns that will be installed as text fields 
- The ID field should have integers and be in ascending order.
- The name field should  list the clone/family name. 
- The input CSV file should not have any blank spaces.
* Formula Document: http://treesearch.fs.fed.us/pubs/7354

Common Problems: TBD

