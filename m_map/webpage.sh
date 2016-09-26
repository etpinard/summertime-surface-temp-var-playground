#! /bin/bash
# 
# Opens Google Chrome to the M_Map web page
# and send "success" messages to ~/.chrome.log 

google-chrome www2.ocgy.ubc.ca/~rich/map.html \
1> ~/.chrome.log 2> ~/.chrome.log &
