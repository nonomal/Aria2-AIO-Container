#!/bin/sh

DRIVE_NAME_AUTO="$(sed -n '1p' /mnt/data/config/rclone.conf | sed "s/\[//g" | sed "s/\]//g")"
if [ "${DRIVE_NAME}" = "auto" ]; then
    DRIVENAME=${DRIVE_NAME_AUTO}
else
    DRIVENAME=${DRIVE_NAME}
fi

DRIVE_DIR="$(grep ^drive-dir /mnt/data/config/script.conf | cut -d= -f2-)"
FILEPATH=$(echo $1 | sed 's:[^/]*$::')
FILENAME=$(echo $1 | sed 's:/.*/::')

if [[ "${POST_MODE}" =~ "move" ]]; then
    rclone rc --user "${USER}" --pass "${PASSWORD}" --rc-addr=localhost:56802 operations/movefile srcFs="${FILEPATH}" srcRemote="${FILENAME}" dstFs="${DRIVENAME}":"${DRIVE_DIR}" dstRemote="${FILENAME}" _async=true
elif [[ "${POST_MODE}" =~ "copy" ]]; then
    rclone rc --user "${USER}" --pass "${PASSWORD}" --rc-addr=localhost:56802 operations/copyfile srcFs="${FILEPATH}" srcRemote="${FILENAME}" dstFs="${DRIVENAME}":"${DRIVE_DIR}" dstRemote="${FILENAME}" _async=true
fi