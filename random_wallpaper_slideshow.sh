#!/bin/bash

# Reads images in given directory, picks random one and set it as background.
# To prevent repetition, once displayed images are stored in file and excluded from
# further selection. When there is no image to be displayed process starts all over again.
#
#
# Created: 1.11.2017
# Author: Jan Fryblik jan.fryblik(at)ebrothers.cz

WALLPAPERDIR="$HOME/wallpapers"
SHOWN_FILES_PATH="$HOME/.fluxbox/shown_indexes.data"


echo "start"
if [[ -d "${WALLPAPERDIR}" ]]
then
	files=$(ls "${WALLPAPERDIR}")
	all_files=($files)
	all_files_count=${#all_files[*]}

	if [[ ! -f "${SHOWN_FILES_PATH}" ]]; then
		touch "${SHOWN_FILES_PATH}"
	fi

	while (true)
	do
        readarray shown_files < $SHOWN_FILES_PATH
		shown_files_count=${#shown_files[*]}

		#echo "All: ${all_files_count}"
		#echo "Shown: ${shown_files_count}"

		if [ ${shown_files_count} -eq ${all_files_count} ]; then
			# if all files shown delete data file
			rm "$SHOWN_FILES_PATH";

			shown_files=()
			shown_files_count=0
			
			#echo "Delete ${SHOWN_FILES_PATH}..."
		fi

		# find all files which haven't been shown
		unshown_files=()
		counter=0;
		for file in ${all_files[*]}; do
			is_in_shown=0;
			for show_file in ${shown_files[*]}; do
				if [ "$file" == "$show_file" ]; then
					is_in_shown=1
				fi
			done

			#echo "Soubor $file > $is_in_shown"

			if [ ${is_in_shown} -eq 0 ]; then
				unshown_files[$counter]=${file};
			    let counter=$counter+1
				#echo $counter
			fi
        done
        unshown_files_count=${#unshown_files[*]}
        #echo "Unshown: ${unshown_files_count}"

		# pick a random previously unshown file
		random_number=$((RANDOM%unshown_files_count))
		random_file=${unshown_files[${random_number}]};
		echo $random_file >> $SHOWN_FILES_PATH;

		# set background
		fbsetbg -f "${WALLPAPERDIR}/$random_file"

		sleep 10m
		#sleep 0.2
	done
fi

exit 0
