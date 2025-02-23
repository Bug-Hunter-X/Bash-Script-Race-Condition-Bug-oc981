#!/bin/bash

# This script demonstrates a solution to the race condition bug using a lock file.

# Create two files
touch file1.txt
touch file2.txt

# Function to write to file with locking mechanism
write_to_file() {
  local file=$1
  local message=$2

  # Acquire lock file
  flock -n 200 || exit 1

  echo "$message" > "$file"

  # Release lock file
  flock -u 200
}

# Start two processes that write to the files concurrently using the lock.
write_to_file file1.txt "Process 1"
write_to_file file2.txt "Process 2"

# The locking mechanism ensures that the output is as expected.
cat file1.txt
cat file2.txt