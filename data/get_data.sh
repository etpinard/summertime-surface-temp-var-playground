#! /bin/bash
# 
# Opens Google Chrome to IRIDL LDEO CMIP3 data bank 
# and send "success" messages to ~/.chrome.log 

google-chrome iridl.ldeo.columbia.edu/SOURCES/.WCRP/.CMIP3/ \
1> ~/.chrome.log 2> ~/.chrome.log &
