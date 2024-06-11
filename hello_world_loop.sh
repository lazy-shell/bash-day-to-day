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

# Define a function to print "Hello, World!" every 30 seconds
function print_hello_world_loop() {
    # Loop to print "Hello, World!" every 30 seconds
    while true; do
        # Get the current date and time in 12-hour format with AM/PM
        current_time=$(date +"%Y-%m-%d %I:%M:%S %p")

        # Print "Hello, World!" with the counter and current time
        echo "Hello, World! $counter - $current_time"
        
        # Increment the counter
        ((counter++))

        # Supervisor commands
        sudo supervisorctl reread
        sudo supervisorctl update
        sudo service supervisor restart

        # Wait for 30 seconds
        sleep 30
    done
}

# Call the function
print_hello_world_loop
