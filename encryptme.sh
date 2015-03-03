#!/usr/local/bin/bash
# Encrypts the archive folder
# Author: Enrique Valenzuela <enrique.valenzuela@blackboard.com>
# Version 1.0


##### Constants
TITLE="System Information for $HOSTNAME"
DATE=`date +"%Y-%m-%d-%s"`
TIMESTAMP="Updated on $DATE by $USER"
GZEXT='.gz'


function validate(){

  if [ -z "${FOLDER}" ]; then
    echo '====================================================='
    echo "Error: Folder can't be empty, please refer to the help."
    echo '====================================================='
    echo "Here is the usage: "
    help
    exit 1
  elif [ -z "${PASSWORD}" ]; then
    echo '====================================================='
    echo "Error: Passowrd can't be empty, please refer to the help."
    echo '====================================================='
    echo "Here is the usage: "
    help
    exit 1
  else
    getFiles
  fi
}

function getFiles(){

  #passfile=$(createEncryptPassFile)
  # create password file in temp folder

  

  if [ -d "$FOLDER" ]; then
    # the directory exists
    cd $FOLDER
    #echo $(pwd)
    #find all the files that are zips in the folder
    files=$(ls *.zip)
    #counter
    count=0
    for file in $files;
    do
      # encrypt all the files in the for loop that were previously found
      $(echo $PASSWORD  | gpg -cv --passphrase-fd 0 -o $FOLDER/$file.gpg --cipher-algo AES256 $FOLDER/$file )

      echo " "
      # remove the file after it has been encrypted
      rm $file
      count=$((count+1))
    done
    echo $count
  fi

}





# Function to provide the help to the screen if its invoked or no parameter is sent to the script
function help()
{
	cat << EOF
usage: $0 options

This script encrypts and compresses a folder full of archives for later download.
Also, its to noted that the original files will be deleted after encrypted.
NOTE: All fields are mandatory

OPTIONS:
   -h     Show this message
   -f     Folder to be encrypted
   -p     Password to encrypt the archives

EOF
}

################



#SCRIPT START
# checking if the user didnt input anything and just ran the script
if [ -z $1 ]; then
  help
  exit 1
else
  # validating and assigning the variables to each global variable
  while getopts "hf:p:" opts
  do
    case $opts in
      h)
        help
        exit 1 ;;
      f) FOLDER=${OPTARG}  ;;
      p) PASSWORD=${OPTARG}  ;;
    esac
  done
fi

validate
