# 输入
# LOGIN_URL="http://:8848/nacos/v1/auth/users/login"
# LOGIN_DATA="username=nacos&password=nacos"
# CHECK_URL="http://:8848/nacos/v1/ns/catalog/instances?&serviceName=[]&clusterName=DEFAULT&groupName=[]&pageSize=10&pageNo=1&namespaceId=[]"
# LOGIN_K="accessToken"
# KEY_WORD="30.31.16.108|30.1.10.1"
# IP 的两倍
# ROWS="4"

LOGIN_RES=`curl -c /tmp/cookie $LOGIN_URL -d "$LOGIN_DATA" | python -m json.tool`
echo "$LOGIN_RES"

LOGIN_V=`echo "$LOGIN_RES" | sed -n "s/.*${LOGIN_K}\": \"\([^\"]*\).*/\1/p"`
echo "LOGIN_V:"
echo "$LOGIN_V"

CHECK_RES=`curl -b /tmp/cookie $CHECK_URL | python -m json.tool`
echo "$CHECK_RES"

GREP_TEXT=`echo "$CHECK_RES" | grep -E "$KEY_WORD"`
echo $GREP_TEXT

GREP_ROWS=`echo "$GREP_TEXT" | wc -l`
if [ "$GREP_ROWS" != $ROWS ] ; then
  exit 1;
fi