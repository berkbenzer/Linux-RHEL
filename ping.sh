#!/bin/bash

# Define the list of IP addresses
IPList=("10.1.1.1" "10.1.1.2" "10.1.1.3")
# Initialize counters
TotalPings=0
Timeouts=0

# Create a unique log file based on the current date and time
timestamp=$(date +"%Y%m%d_%H%M%S")
log_file="/home/user/ping_results.txt"

# Loop through each IP address and ping it
for ip in "${IPList[@]}"
do
    TotalPings=$((TotalPings + 1))
    ping_time=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$ping_time] Pinging $ip ..."
    if ping -c 4 "$ip" > /dev/null; then
        echo "[$ping_time] $ip: Ping Successful" >> "$log_file"
    else
        echo "[$ping_time] $ip: Request Timed Out" >> "$log_file"
        Timeouts=$((Timeouts + 1))
    fi
done

# Write summary to log file
echo "" >> "$log_file"
echo "Total IPs Pinged: $TotalPings" >> "$log_file"
echo "Requests Timed Out: $Timeouts" >> "$log_file"

# Display the summary (optional)
cat "$log_file"
