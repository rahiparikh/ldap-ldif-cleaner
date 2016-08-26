#!/usr/bin/env bash

echo -e ""
echo -e "LDAP LDIF Cleaner v1"
echo -e "Copyright 2016 Rahil Parikh"
echo -e "Apache License 2.0 (http://www.apache.org/licenses/LICENSE-2.0)"
echo -e ""

if [ "$#" -ne 2  ]; then
      echo -e "Illegal number of parameters."
      echo -e ""
      echo -e "Usage: ldif_cleaner.sh [source] [destination]"
      echo -e ""
      echo -e "[source]       Source file with LDAP export in LDIF format"
      echo -e "[destination]  Output file that will have cleaned/extracted data from source file"
      echo -e
      exit
fi

if [ -f $2 ]
then
  echo -e "The destination file already exists! Exiting."
  exit
fi

echo -e "Cleaning up LDIF file."
touch $2

while read LINE
do
  #DECODED_HASH=`echo -n $LINE | base64 --decode`
  #echo -e "$DECODED_HASH" >>$2
  if [[ $LINE == *"uid:"* ]]
  then
    USER_ID=`echo -e $LINE | cut -d' ' -f2`
    read LINE
    if [[ $LINE == *"userPassword:"* ]]
    then
      PASSWORD=`echo -e $LINE | cut -d' ' -f2`
      DECODED_HASH=`echo -e $PASSWORD | base64 --decode`
      echo -e "$USER_ID:$DECODED_HASH" >>$2
    fi
  fi
done < <(egrep 'uid:|userPassword:' $1)
echo -e "Done!"
echo -e ""
