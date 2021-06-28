LOG_FILE=`ls -rd $LOG_PATH | head -1`
echo $LOG_FILE

GREP_TEXT=`grep -r -E "$KEY_PATTERN" "$LOG_FILE"`
echo $GREP_TEXT

GREP_LEN=${#GREP_TEXT}

if [ "$GREP_LEN" = 0 ] ; then
  exit 1;
fi