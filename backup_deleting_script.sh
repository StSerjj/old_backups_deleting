#!/bin/bash

backup_path=("/home/ssv/backup_delete_test/sql_backups/folder1/" "/home/ssv/backup_delete_test/sql_backups/folder2/" "/home/ssv/backup_delete_test/sql_backups/folder3/")
time_between_backups=1440 #промежуток времени между созданием бэкапов (в минутах). Проверка на случай бесконтрольного создания бэкапов.
remaining_count=62     #кол-во бэкапов, которое мы хотим хранить

for current_folder in ${backup_path[@]};
do
        cd $current_folder
        count_all_files=$(ls -1 "$current_folder" | wc -l)
        duplication_files=$(find "$current_folder" -type f -mmin -"$time_between_backups" | wc -l)

        if [ "$duplication_files" -ge 2 ];
        then

                exit 0

        else

                while [ "$count_all_files" -ge "$remaining_count" ]
                do
                        ls -t "$current_folder" | tail -n 1 | xargs rm -f
                        count_all_files=$(ls -1 "$current_folder" | wc -l)
                done

        fi
done