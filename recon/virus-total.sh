#!/bin/bash

# VirusTotal API v3 key
API_KEY="<ur-api-key>"

search_vt() {
  # check if input is a URL
  if [[ $1 =~ ^https?:// ]]; then
    query="{\"url\":\"$1\"}"
    endpoint="urls"
  # check if input is a file hash
  elif [[ $1 =~ ^[a-f0-9]{64}$ ]]; then
    query="{\"hash\":\"$1\"}"
    endpoint="files"
  # check if input is an IP address
  elif [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    query="{\"ip\":\"$1\"}"
    endpoint="ip_addresses"
  else
    echo "Invalid input. Please enter a URL, file hash, or IP address."
    exit 1
  fi

  # send request to VirusTotal API v3
  result=$(curl --request GET \
              --url "https://www.virustotal.com/api/v3/$endpoint/$1" \
              --header "x-apikey: $API_KEY" \
              --header 'content-type: application/json')
  
  # replace \r\n with newlines in the result
  result=$(echo "$result" | sed 's/\\r\\n/\n/g')

  # print the result
  echo "$result"
}

# check if input was provided
if [[ $# -eq 0 ]]; then
  echo "Please provide a URL, file hash, or IP address."
  exit 1
fi

# search for input in VirusTotal API v3
search_vt "$1"

