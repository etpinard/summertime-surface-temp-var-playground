#! /bin/bash
# 
# Opens Google Chrome to RGB website useful for making color maps
# and send "success" messages to ~/.chrome.log 

google-chrome http://colorbrewer2.org/ \
1> ~/.chrome.log 2> ~/.chrome.log &

