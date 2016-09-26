#! /bin/bash
# 
# Opens Google Chrome to the ATM S data sharing Catalyst Message Board
# Sends "success" messages to ~/.chrome.log 

google-chrome catalyst.uw.edu/gopost/area/dargan/88589 \
1> ~/.chrome.log 2> ~/.chrome.log &
