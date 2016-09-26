#! /bin/bash
# 
# Programme that clears all figures stored in
# ~/proj/etienne/*/figs/eps (or png) and
# ~/proj/etienne/*/figs/*/archives	to free disk space.
# ======================================================================

# I should make an if statement for the file extension ...
ext=".eps"

# first find all .eps (or .png) files
find . -name "*$ext" > tmp.txt 

	# print files to screen and the total size if tmp.txt is non-empty
if [[ -s tmp.txt ]]; then
	echo -e "\nRemoving the following files: \n"
	cat tmp.txt
	echo -e "\nResulting in:"
	du -ch $(cat tmp.txt) | tail -n -1
	echo -e "of memory\n"

		# prompt 
	echo -e "\n Is that OK? [Y/N] \n"
	read answer
	
	if [[ $answer == Y ]]; then
	
			# remove line by line from tmp.txt file
		for line in $(cat tmp.txt); do
	
			echo "removing --> $line"
			rm $line
		
		done
	
	else 
		echo ABORTED!
	fi

else
	echo -e "\n\tNo $ext figure files found \n"
fi

# Then find all archives/ folders
find . -name "archives" > tmp.txt

	# print folders to screen
echo -e "Removing all figures in the following archive folders: \n"
cat tmp.txt
echo -e "\nResulting in:"
du -ch $(cat tmp.txt) | tail -n -1
echo -e "of memory\n"

	# prompt
echo -e "\n Is that OK? [Y/N] \n"
read answer

if [[ $answer == Y ]]; then
	
	for line in $(cat tmp.txt); do

			# remove line by line ...
		echo "removing --> $line"
		rm $line/*
	
			# should I include subfolders too such as in toy_model/	?

	done

else 

	echo ABORTED!

fi

# clear tmp.txt
rm tmp.txt
