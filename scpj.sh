#!/bin/bash
#---------------------------------------
# gauthams@nio.res.in
# created on 10/10/2024
#---------------------------------------
JUMP_HOST="username@gateway_address"
TARGET_HOST="username@target_server_address"
TARGET_BASE_PATH="/home/gauthams"
#---------------------------------------

if [ "$#" -ne 2 ]; then
    echo "Usage: scpj '<file_pattern>' <TARGET_HOST>"
    echo "Description: Bypass Gateway Using scp -J"
    exit 1
fi

if [[ "$2" == /* ]]; then
    TARGET_PATH="${TARGET_BASE_PATH}$2"
else
    TARGET_PATH="${TARGET_BASE_PATH}/$2"
fi

files=($1)

if [ ${#files[@]} -eq 0 ]; then
    echo "No files matched the pattern '$1'."
    exit 1
fi

echo "Copying '$1' to '${TARGET_HOST}:$TARGET_PATH' via '$JUMP_HOST'"
for file in "${files[@]}"; do

    scp -J "$JUMP_HOST" "$file" "${TARGET_HOST}:$TARGET_PATH"
done

if [ $? -eq 0 ]; then
   echo -e "File '$1' copied successfully!\n"
else
   echo -e "File '$1' copy failed!\n"
fi
