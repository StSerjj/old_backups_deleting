#!/bin/bash
backup_path="/home/ssv/backup_delete_test/sql_backups/"
cd $backup_path
count_all_files=$(ls -1 "$backup_path" | wc -l)
echo Всего файлов: $count_all_files
duplication_files=$(find "$backup_path" -type f -mmin -1 | wc -l)
if [ $duplication_files -ge 2 ];
then 
	exit 0
else	
	while [ $count_all_files -ge 10 ]
	do
		echo "итерация цикла"
		ls -t "$backup_path" | tail -n 1 | xargs rm -f
		count_all_files=$(ls -1 "$backup_path" | wc -l)
	done
echo Файлов осталось: $count_all_files
fi
