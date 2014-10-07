#!/usr/local/bin/bash
# Encrypts the archive folder
# Author: Enrique Valenzuela <enrique.valenzuela@blackboard.com>
# Version 1.0


##### Constants
TITLE="System Information for $HOSTNAME"
DATE=`date +"%Y-%m-%d"`
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
  elif [[ -z "${COMPRESS}" || "${COMPRESS}" == *[[:digit:]]* ]]; then
    echo '====================================================='
    echo "Error: Compress can't be empty or be a digit, please refer to the help."
    echo '====================================================='
    echo "Here is the usage: "
    help
    exit 1
  else
    getFiles
  fi
}

function getFiles(){
  createEncryptPassFile
  if [ -d "$FOLDER" ]; then
    # the directory exists
    cd $FOLDER
    #echo $(pwd)
    files=$(find . -name *.zip)
    for file in $files;
    do
      echo $file;
    done
  fi
  #removeEncryptFile
}
function createEncryptPassFile(){
  filename = ${PASSWORD}
  echo #filename
  #cat "${PASSWORD}" >> /tmp/
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
   -c     Compress after the encryption (yes or no)

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
  while getopts "hf:p:c:" opts
  do
    case $opts in
      h)
        help
        exit 1 ;;
      f) FOLDER=${OPTARG}  ;;
      p) PASSWORD=${OPTARG}  ;;
      c) COMPRESS=${OPTARG}  ;;
    esac
  done
fi

validate
