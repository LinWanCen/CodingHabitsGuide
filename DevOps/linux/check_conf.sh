# 配置修改检查
# 查找目录 FIND_PATH=/home/
# 文件类型 EXT_NAME=yml|properties|xml|jsp|conf.*
# 测试IP等 KEY_PATTERN=
GREP_TEXT=`find $FIND_PATH -regextype 'posix-egrep' -type f -regex ".*\.($EXT_NAME)" | xargs grep -E "30\.[0-1]\."`
echo "$GREP_TEXT"

GREP_LEN=${#GREP_TEXT}

if [ "$GREP_LEN" != 0 ] ; then
    exit `echo "$GREP_TEXT"|wc -l`
fi