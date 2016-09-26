#! /bin/bash
# 
# Opens Google Chrome to IRIDL LDEO CMIP3 data bank 
# and send "success" messages to ~/.chrome.log 

google-chrome \
http://www.ecmwf.int/products/data/technical/soil/discret_soil_lay.html \
1> ~/.chrome.log 2> ~/.chrome.log &
