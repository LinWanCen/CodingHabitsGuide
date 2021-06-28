ss -tnlp | grep -E "Address|$KEY_PATTERN"

GREP_ROWS=`ss -tnlp | grep -E "$KEY_PATTERN" | wc -l`
if [ "$GREP_ROWS" != $ROWS ] ; then
  exit 1;
fi