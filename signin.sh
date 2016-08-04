#!/usr/bin env bash

# CbTimeLogger  - signin
# PURPOSE : A CLI for CodeBrahma employees to sign in before running 'logger.sh'
# AUTHOR  : tbking <tarun.batra00@gmail.com>
# LICENSE : MIT

# Read config file
. setup.conf

# Make web call for sign in and dump the response headers in 'headers.txt'
curl \
-D headers.txt \
-H "Content-Type: application/json" \
-d "{\"email\": \"$EMAIL\", \"password\": \"$PASSWORD\" }" \
$SIGN_IN_URL &> /dev/null
