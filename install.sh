#!/bin/bash

# Include the function library
source ./functions.sh

# Verify permissions before we continue, if it fails then exit
isRoot

# Adding a proper user account
addUserAccount