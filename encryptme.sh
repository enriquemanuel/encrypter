#!/bin/bash
# Encrypts the archive folder
# Author: Enrique Valenzuela <enrique.valenzuela@blackboard.com>
# Version 1.0


##### Constants
TITLE="System Information for $HOSTNAME"
RIGHTNOW=$(date +"%x %r %Z")
TIMESTAMP="Updated on $RIGHT_NOW by $USER"

function help()
{
	cat << EOF
usage: $0 options

This script encrypts and compresses a folder full of archives for later download.
Also, its to noted that the original files will be deleted after encrypted.

OPTIONS:
   -h     Show this message
   -f     Folder to be encrypted
   -p     Password to encrypt the archives
   -c     Compress after the encryption (yes or no)

EOF
}

# checking if the user didnt input anything and just ran the script
if [ -z $opts ]; then
  help
  exit 1
fi
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
