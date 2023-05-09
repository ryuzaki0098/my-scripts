#!/bin/bash

# Set your VirusTotal API key here
VT_API_KEY="api-key"
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
    whois_output=$(whois "${domain}")
    echo "${whois_output}"

    # Extract the IP address from the WHOIS output
    ip_address=$(echo "${whois_output}" | awk '/^   [Ii][Pp] [Aa]ddress:/ {print $NF}')
    echo "IP Address: ${ip_address}"
fi

# Query the IP address through VirusTotal
if [[ -n "${ip_address}" ]]; then
    # Query the IP address
    curl -X GET "https://www.virustotal.com/api/v3/ip_addresses/${ip_address}" \
        -H "x-apikey: ${VT_API_KEY}" \
        | jq .

    # Query the location of the IP address using ipinfo.io
    location=$(curl -s "https://ipinfo.io/${ip_address}/geo" \
        | jq -r '.country')
    echo "Location: ${location}"
fi

# Query the domain name through VirusTotal
if [[ -n "${domain}" ]]; then
    curl -X GET "https://www.virustotal.com/api/v3/domains/${domain}" \
        -H "x-apikey: ${VT_API_KEY}" \
        | jq .
fi

