#!/usr/bin/env bash

# Array of crates to publish
CRATES=(
    yazi-macro
    yazi-codegen
    yazi-shared
    yazi-ffi
    yazi-fs
    yazi-config
    yazi-proxy
    yazi-adapter
    yazi-boot
    yazi-binding
    yazi-dds
    yazi-scheduler
    yazi-plugin
    yazi-widgets
    yazi-core
    yazi-fm
    yazi-cli
)

# Function to publish a single crate with specified sleep time
publish_crate() {
    local crate=$1
    local sleep_time=$2
    # Publish the crate
    cargo publish -p "$crate"
    # Check if publish was successful
    if [ $? -ne 0 ]; then
        # Exit on failure
        exit 1
    fi
    # Sleep if specified
    if [ "$sleep_time" -gt 0 ]; then
        sleep "$sleep_time"
    fi
}

# Main function to publish all crates
main() {
    local sleep_time=30
    for crate in "${CRATES[@]}"; do
        # Use 0 sleep for the last crate
        if [ "$crate" == "${CRATES[-1]}" ]; then
            publish_crate "$crate" 0
        else
            publish_crate "$crate" "$sleep_time"
        fi
    done
}

# Execute main function
main
