
CONFIG_PATH=/data/options.json

CMD_LINE="$(jq --raw-output '.cmd_line' $CONFIG_PATH)"

# For debug
# echo ">ls -l /dev/tty*"
# ls -l /dev/tty*
# echo ">test -w /dev/ttyUSB0 || echo Error"
# test -w /dev/ttyUSB0 || echo Error

avrdude $CMD_LINE

