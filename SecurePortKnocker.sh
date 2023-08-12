#!/bin/bash

# Initialize arrays to hold port values
PORTS=()
IP_ADDRESS=""

# Default port values
DEFAULT_PORTS=("1234" "5678" "9012")

# Function to display script usage and exit with error status
usage() {
    echo "Usage: $0 -p <port1> -p <port2> -p <port3> -i <IP Address>"
    echo "Example: $0 -p 1234 -p 5678 -p 9012 -i 192.168.1.100"
    exit 1
}

# Parse command line arguments
while getopts ":p:i:" opt; do
    case $opt in
        p)
            PORTS+=("$OPTARG")
            ;;
        i)
            IP_ADDRESS="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            usage
            ;;
    esac
done

# Use default ports if none specified
if [ "${#PORTS[@]}" -eq 0 ]; then
    PORTS=("${DEFAULT_PORTS[@]}")
fi

# Check if IP_ADDRESS is provided
if [ -z "$IP_ADDRESS" ]; then
    echo "IP Address is required."
    usage
fi

# Perform port knocking
echo "Knocking the following ports: ${PORTS[*]} ..."
for port in "${PORTS[@]}"; do
    nmap --host-timeout 100 --max-retries 0 -PN "$IP_ADDRESS" -p "$port" > /dev/null 2>&1
    sleep 1  # Wait for a short period before the next knock
done

# Check for errors in nmap execution
if [ $? -eq 0 ]; then
    echo "Port knocking completed successfully."
else
    echo "Port knocking failed. Exiting."
    exit 1
fi

echo "Checking for new open ports with nmap ..."
nmap -sT -p- -r -n "$IP_ADDRESS" --open | grep open
