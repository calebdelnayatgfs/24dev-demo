#!/bin/bash
# File: r4st-loader.sh 

<<COMMENT_OUT
COMMENT_OUT

echo "Starting script on:" $(date)
echo
echo "Always source the mydev profile..."
myDevBase=$(pwd|cut -d"/" -f-5)
. ${myDevBase}/.24dev.profile
echo "MYDEV_NAME=$MYDEV_NAME"
echo "BASE=$BASE"
echo "APPS=$APPS"
echo 

cat <<-EOF 
Usage: r4st-loader.sh 
This program will execute the pgsql commands to create and load r4st database objects 
EOF
echo 

# Display the 24dev-r4st Release and License Details:
cat ${DOCS}/24dev-r4st-ReleaseAndLicense.txt
echo 

echo
echo  "INFO: Drop and Load the TST Test tables..."   
psql r4t -f ../sql/TST/r4st-TST-Load-AllTables.sql
echo  "INFO: Create TST pedigree csv file from the recursive SQL file and load into the pedigree table:"     
psql r4t -F "|" -t -f ../sql/TST/r4st-TST-pedigree.sql|grep . > ../csv/TST/r4st-TST-pedigree.csv
psql r4t -f ../sql/TST/r4st-TST-Copy.filelist -a
echo

echo
echo  "INFO: Drop all existing tables and views from the PRD database..."
psql r4p -f ../sql/r4st_DropAll-Objects.sql
echo

echo
echo  "INFO: Load the primary tables with the default initial inserts..."
psql r4p -f ../sql/r4st-Load-AllTables.sql

echo
echo  "INFO: Load the primary data for the above tables..." 
psql r4p -f  ../sql/r4st-Copy.filelist -a
echo

echo
echo  "INFO: Load updates for the above tables..." 
psql r4p -f  ../sql/r4st_Updates.sql
echo

echo  "INFO: Create PRD pedigree csv file from the recursive SQL file and load into the pedigree table:"     
psql r4p -F "|" -t -f ../sql/r4st-pedigree.sql|grep . > ../csv/r4st-pedigree.csv
psql r4p -f  ../sql/r4st-Copy-PostLoad.filelist  -a
echo

echo
echo  "INFO: Load the r4stdb AVW basic table VIEWS with foreign keys..." 
psql r4p -f  ../sql/r4st_Views-avw-baseTables.sql
echo

echo
echo  "INFO: Load the r4stdb descriptive table VIEWS..." 
psql r4p -f  ../sql/r4st_Views-vw-TrialOrEvents.sql
echo

echo 
echo "Create a dump of the master PRD database, then load it into an existing but empty SIT database... "
 pg_dump r4p > r4p.dump.sql
echo

echo  "INFO: Drop all existing tables and views from the SIT database..."
 psql r4s -f ../sql/r4st_DropAll-Objects.sql
echo
echo "Load the PRD data into the SIT database... "
echo "... Only works on an empty database so only run once - Need to add repeatability..."  
  psql r4s < r4p.dump.sql 
echo
echo

echo 
echo "Create a new version of the r4st_DropAll-Objects.sql file..."
psql r4p -c "\dt" |grep table|cut -f2 -d"|"|awk '{print "DROP TABLE if exists " $1 " CASCADE;"}' > ../sql/r4st_DropAll-Objects.sql 
psql r4p -c "\dv" |grep view|cut -f2 -d"|"|awk '{print "DROP VIEW if exists " $1";"}' >> ../sql/r4st_DropAll-Objects.sql 
echo

echo
echo "Extract all table description data via pgsql and load into a text file" 
echo "id~table_name~table_description" > ../csv/table_description.txt
for tableName in $(psql r4p -c "\dt" |grep table|cut -f2 -d"|")
do
    idCount=$((idCount+1))
    echo "#################  Table Nbr: $idCount ######  Table Name: $tableName ##############################################" >> ../csv/table_description.txt
    psql r4p -c "\d $tableName" |sed 's/"//g' > ../csv/TMP.txt                
    cat ../csv/TMP.txt   >> ../csv/table_description.txt
done
echo
rm ../csv/TMP.txt


echo "Check for undesireable characters in the CSV files..."
chkBadChars=$(grep -R '"' ../csv/*)
if [[ -n $chkBadChars ]]; then
  echo "ERROR: Found double quotes in the CSV files! Please remove them..."
fi   

echo "The r4st database process is: DONE"
psql --version

