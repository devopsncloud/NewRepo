#!/bin/bash

file=/etc/passwd


#check whether the file exists or not

if [ ! -f $file ]
then
	echo "The file doesn't exist"
fi

while IFS=":" read -r username password user_id group_id full_name home_dir shell_path 
do 
	echo "username: $username"
	echo "password: $password"
	echo "user_id: $user_id"
	echo "group_id: $group_id"
	echo "full_name: $full_name"
	echo "home_dir: $home_dir"
	echo "shell_path: $shell_path"

done < $file
