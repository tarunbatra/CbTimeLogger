# CbTimeLogger
A command line interface for CodeBrahma employees to log time

## Installation
- Clone the project by running: `git clone https://github.com/tarunbatra/CbTimeLogger`
- Create a config file, `setup.conf` as described [below](#configuration)

## Usage
- `cd` to the project root
- Run `bash logger.sh`

## Configuration
`setup.conf` should look like:
```
PROJECT=123                             # Project ID
EMAIL=some@emil.com                     # Your registered email id
PASSWORD=somepassword                   # Password for time logging service
DEFAULT_HOURS=12                        # Hours to log by default
SIGN_IN_URL=https://some.url.com        # API to sign in
TIME_LOG_URL=https://some.url.com       # API to log time
```
## Disclaimer
This script is intended to supplement, and not replace the time logging system already in place. It performs bare minimum functions and contributions are welcomed to include more features. Happy time logging! 🤘
