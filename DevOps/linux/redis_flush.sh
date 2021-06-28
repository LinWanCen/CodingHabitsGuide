if [ 0"$PORT" != "0" ]; then
    CLI_PATH="$CLI_PATH -p $PORT"
fi

if [ 0"$AUTH" != "0" ]; then
    CLI_PATH="$CLI_PATH -a $AUTH"
fi

RES=`$CLI_PATH flushAll`
echo "$RES"

if test "$RES" = "OK"
then
  exit 0
else
  if test "$RES" = "READONLY You can't write against a read only replica."
  then
    exit 0
  fi
  exit 1
fi