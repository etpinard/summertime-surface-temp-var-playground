#! /bin/bash
# 
# Opens Google Chrome to a RGB website useful for making color maps
# and send "success" messages to ~/.chrome.log 

google-chrome http://www.tayloredmktg.com/rgb/ \
1> ~/.chrome.log 2> ~/.chrome.log &

