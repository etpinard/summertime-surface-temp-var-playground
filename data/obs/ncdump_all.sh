#! /bin/bash
#
#	Runs ncdump -h on all .cdf files in the current directory
#
#	--- The inline version does not work in cshell	
#
# ======================================================================

cd ~/nobackup/data/obs

for f in *.cdf
do
	ncdump -h $f
done
