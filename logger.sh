#!/usr/bin env bash

# Read config file
. setup.conf

# Method to trim trailing character from a string
trimNewLine() {
  read arg
  local LENGTH=`echo "${#arg} - 1" | bc`
  local result=`echo $arg | cut -c1-$LENGTH`
  echo "$result"
}

# Show help menu if asked by client
if [[ $* == -h || $* == --help ]]; then
  echo "
  Usage:  bash logger.sh ([hours] [date] | [-h] [--help])

          hours     - Number of hours you want to log. If not providing this argument, set 'DEFAULT_HOURS' in 'setup.conf
          date      - Date in dd/mm/yyyy format to log time against. It defaults to today's date if not provided
          -h --help - Displays this menu

  Example:  bash logger.sh
            bash logger.sh 8 01/01/1970
            bash logger.sh -h
  "
  exit 1
fi

# Check if the user logged in
if [ ! -f headers.txt ]; then
  echo "Please sign in first using:
  bash signin.sh"
  exit 1
fi

# Get user authentication data
USER=`awk '/^uid/{print $2}' headers.txt | trimNewLine`
TOKEN=`awk '/^access-token/{print $2}' headers.txt | trimNewLine`
CLIENT=`awk '/^client/{print $2}' headers.txt | trimNewLine`

# Set default hours
HOURS=$DEFAULT_HOURS

# Set current date as default
DATE=`date +%d/%m/%Y`

# If hours are provided as first argument, override default hours
if [ -n "$1" ]; then
    HOURS=$1
fi

# If date is provided as second argument, override default date
if [ -n "$2" ]; then
    DATE=$2
fi

# Make the web call to log time
curl -v \
-H "Content-Type: application/json" \
-H "access-token: $TOKEN" \
-H "Client: $CLIENT" \
-H "uid: $USER" \
-d "{\"pid\": \"$PROJECT\", \"date\": \"$DATE\", \"hours\": \"$HOURS\" }" \
$TIME_LOG_URL &> time.log

# Inform user about the result of the operation
if [ 0 -eq $? ]; then
  echo "Time logged successfully"
else
  echo "Time logging failed. See time.log for more details." # time.log pun intended :P
  echo `date` >> time.log
fi;
