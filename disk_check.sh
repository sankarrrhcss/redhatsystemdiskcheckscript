#!/bin/bash

while true; do
    # Run disk space check using df
    disk_usage=$(df -h /)

    # Extract the percentage of disk space used
    disk_percentage=$(echo "$disk_usage" | awk 'NR==2 {print $(NF-1)}' | tr -d '%')

    # Set a threshold for disk space usage (adjust as needed)
    threshold=90

    # Check if disk usage exceeds the threshold
    if [ "$disk_percentage" -gt "$threshold" ]; then
        # Send an email alert
        subject="Disk Space Alert - $HOSTNAME"
        message="Disk space usage on $HOSTNAME is $disk_percentage%. Please take action."

        echo "$message" | mail -s "$subject" your@email.com
    fi

    # Sleep for 5 minutes before the next check
    sleep 300
done