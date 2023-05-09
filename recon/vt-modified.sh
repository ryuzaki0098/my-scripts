#!/bin/bash

# Set your VirusTotal API key here
VT_API_KEY="f67bbb476ef08bd9d11a48577f31b32d900ac929c04260a1ee933bc34249d3df"

# Get the file hash, IP address, and URL from user input
read -p "Enter the file hash (MD5, SHA1, or SHA256): " file_hash
read -p "Enter the IP address: " ip_address
read -p "Enter the URL: " url

# Extract the domain name from the URL
if [[ -n "${url}" ]]; then
    domain=$(echo "${url}" | sed -E 's|^(https?://)?(www\.)?([^/]+).*|\3|')
    echo "Domain Name: ${domain}"
fi

# Perform a WHOIS lookup on the domain name
if [[ -n "${domain}" ]]; then
    whois "${domain}"
fi

# Query the domain name through VirusTotal
if [[ -n "${domain}" ]]; then
    curl -X GET "https://www.virustotal.com/api/v3/domains/${domain}" \
        -H "x-apikey: ${VT_API_KEY}" \
        | jq .
fi

# Query the IP address through VirusTotal
if [[ -n "${ip_address}" ]]; then
    curl -X GET "https://www.virustotal.com/api/v3/ip_addresses/${ip_address}" \
        -H "x-apikey: ${VT_API_KEY}" \
        | jq .
fi

