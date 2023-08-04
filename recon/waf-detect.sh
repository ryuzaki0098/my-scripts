#!/bin/bash

read -p "Enter the target website URL: " target_url

user_agents=("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3" "curl/7.55.1")

# Choose a random User-Agent from the array
random_user_agent=${user_agents[$((RANDOM % ${#user_agents[@]}))]}

echo "Checking for WAF presence on $target_url"

response_headers=$(curl -s -I -A "$random_user_agent" "$target_url")

if echo "$response_headers" | grep -q "Server: "; then
    server_header=$(echo "$response_headers" | grep "Server: " | awk -F ': ' '{print $2}')
    echo "User-Agent: $random_user_agent"
    echo "Server header found: $server_header"
    
    # Check for the potential WAF indication
    if [[ "$server_header" ]]; then
        echo "Detected potential WAF: $server_header"
    fi
else
    echo "No WAF detection signatures found."
fi

