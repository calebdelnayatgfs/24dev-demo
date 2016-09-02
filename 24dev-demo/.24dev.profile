#!/bin/bash
# All scripts should first call this profile, adjust as needed. 

# Set scripting global variables:
export BASE=/home/user/Desktop/24dev-demo.0.9.3
export MYDEV_NAME=$(pwd|cut -d"/" -f5)
export APPS=${BASE}/apps                     # eg. /home/user/Desktop/24dev-demo/apps
export DOCS=${BASE}/docs                     # eg. /home/user/Desktop/24dev-demo/docs
