RES=`curl $URL | python -m json.tool`
echo "$RES"

GREP_TEXT=`echo "$RES" | grep -E "$ERR_WORD"`
echo $GREP_TEXT

GREP_LEN=${#GREP_TEXT}

if [ "$GREP_LEN" != 0 ] ; then
  exit 1;
fi