#!/usr/bin/with-contenv bashio

# Extract config options
CONFIG_PATH=/data/options.json
CMD_DOWNLOAD_LINE="$(jq --raw-output '.cmd_download_line' $CONFIG_PATH)"
CMD_FLASH_LINE="$(jq --raw-output '.cmd_flash_line' $CONFIG_PATH)"


# Download update
echo "Downloading the update"
eval $CMD_DOWNLOAD_LINE
echo " "


#echo ">ls -l /dev/tty*"
#ls -l /dev/tty*

# echo ">test -w /dev/ttyUSB0 || echo Error"
# test -w /dev/ttyUSB0 || echo Error

#echo ">ls /"
#ls /

avrdude $CMD_FLASH_LINE

#echo Finished!
