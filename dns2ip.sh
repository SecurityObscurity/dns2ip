#!/bin/bash
# @author: SecObscurity
#
# Simple script to resolv a domain name to an IP address
#
# Output:
#  <domainname> <ip1>,<ip2>

FILE=""
if [[ $# -ne 1 ]];
 then
  echo "Usage: $0 <file_domain_list> "
  echo ""
  exit 127
else
  # check if file exists
  FILE=$PWD"/"$1
  if [[ ! -f "$FILE" ]];
   then
     echo "File $FILE not found"
     echo ""
     exit 128
  fi
fi


while read -r line;
 do
  # echo $line
  # sleep between 0 and 3 seconds
  ssec=$(((RANDOM % 3) ))
  msec=$(((RANDOM % 1000) +1 ))
  #sleep "$ssec"."$msec"s

  dig_output=`dig +noall +time=2 +tries=1 +answer $line`
  isIPv4=`echo $dig_output | grep -E -o '([0-9]{1,3}[\.]){3}[0-9]{1,3}'`
  isIPv6=`echo $dig_output | egrep -o '([a-f0-9:]+:+)+[a-f0-9]+'`

  ip=""
  if [[ ! -z "$isIPv4" ]];
   then
      ip=`echo $isIPv4 | tr ' ' ','`
  elif [[ ! -z "$isIPv6" ]];
   then
      ip=`echo $isIPv6 | tr ' ' ','`
  fi

  echo "$line $ip"

done<$FILE
