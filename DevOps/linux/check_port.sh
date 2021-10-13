# 启动端口检查
# 启动端口正则 KEY_PATTERN=8080|8081
# 启动进程数 ROWS=2
ss -tnlp | grep -E "Address|$KEY_PATTERN"

GREP_TEXT=`ss -tnlp | grep -E "$KEY_PATTERN"`
GREP_ROWS=`echo "$GREP_TEXT" | wc -l`

GREP_LEN=${#GREP_TEXT}
if [ "$GREP_LEN" = 0 ] ; then
  GREP_ROWS=0;
fi

if [ "$GREP_ROWS" != $ROWS ] ; then
  exit 1;
fi