#!/bin/bash

if [ -z "$1" ]; then
  echo "Please provide the file path for the subdomains."
  exit 1
fi

subdomains_file=$1
output_file="output.txt"

echo "Output file: $output_file"

while IFS= read -r subdomain || [[ -n "$subdomain" ]]; do
   echo "========================================================" >> "$output_file"
   echo "Subdomain: $subdomain" >> "$output_file"
   curl -i "$subdomain" >> "$output_file"
done < "$subdomains_file"

