#!/bin/bash

backup_path=("/home/ssv/backup_delete_test/sql_backups/folder1/" "/home/ssv/backup_delete_test/sql_backups/folder2/" "/home/ssv/backup_delete_test/sql_backups/folder3/")

for current_folder in ${backup_path[@]};
do
	cd $current_folder
	count_all_files=$(ls -1 "$current_folder" | wc -l)
	echo Всего файлов: $count_all_files

	duplication_files=$(find "$current_folder" -type f -mmin -1 | wc -l)

	if [ $duplication_files -ge 2 ];
	then

		exit 0

	else

		while [ $count_all_files -ge 10 ]
		do
			echo "итерация цикла"
			ls -t "$current_folder" | tail -n 1 | xargs rm -f
			count_all_files=$(ls -1 "$current_folder" | wc -l)
		done

	echo Файлов осталось: $count_all_files

	fi
done