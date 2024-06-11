#!/bin/bash

# Function to install Supervisor
function install_supervisor() {
    echo "Installing Supervisor..."
    sudo apt-get update
    sudo apt-get install -y supervisor
}

# Check if supervisor is installed
if ! command -v supervisorctl &> /dev/null; then
    echo "Supervisor is not installed. Installing..."
    install_supervisor
fi

# Initialize a counter
counter=1
sleep_time=2  # Adjusted sleep time to 30 seconds

# Define a function to restart Supervisor
function supervisor_restart() {
    local sleep_time=$1  # Accept sleep time as argument
    while true; do
        # Get the current date and time in 12-hour format with AM/PM
        current_time=$(date +"%Y-%m-%d %I:%M:%S %p")

        # Print "Hello, World!" with the counter and current time
        echo "Supervisor Restart Number : $counter - Time : $current_time"
        
        # Increment the counter
        ((counter++))

        # Supervisor commands
        sudo supervisorctl reread
        sudo supervisorctl update
        sudo service supervisor restart

        # Wait for specified seconds
        sleep "$sleep_time"
    done
}

# Call the function with sleep_time as argument
supervisor_restart "$sleep_time"
