#!/usr/bin env bash

# Read config file
. setup.conf

# Make web call for sign in and dump the response headers in 'headers.txt'
curl \
-D headers.txt \
-H "Content-Type: application/json" \
-d "{\"email\": \"$EMAIL\", \"password\": \"$PASSWORD\" }" \
$SIGN_IN_URL &> /dev/null
