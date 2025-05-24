#!/bin/bash

# Define total requests and concurrent processes
TOTAL_REQUESTS=50
CONCURRENT_REQUESTS=10

# Loop through requests
for i in $(seq 1 $TOTAL_REQUESTS); do
  # Capture the time taken for each request
  { time curl -s -X POST http://localhost:8080/email-test/send \
    -H "Content-Type: application/json" \
    -d '{"to": "jonathanremonte@gmail.com", "body": "Test email number '$i'"}'; } 2>&1 | tee -a email_test_results.log &
  
  # Wait for every CONCURRENT_REQUESTS to finish before starting new ones
  if (( $i % $CONCURRENT_REQUESTS == 0 )); then
    wait
  fi
done

# Wait for any remaining background processes to finish
wait
