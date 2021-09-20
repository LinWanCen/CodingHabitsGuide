# 启动端口检查
# 启动端口正则 KEY_PATTERN=8080|8081
# 启动进程数 ROWS=2
ss -tnlp | grep -E "Address|$KEY_PATTERN"

GREP_ROWS=`ss -tnlp | grep -E "$KEY_PATTERN" | wc -l`
if [ "$GREP_ROWS" != $ROWS ] ; then
  exit 1;
fi