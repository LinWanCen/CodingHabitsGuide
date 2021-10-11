#!/bin/sh
# 避免 Oracle 乱码
export NLS_LANG="AMERICAN_AMERICA.AL32UTF8"

INDEX_arr=(0 1)
SUB_DIR_arr=(model1 model2)
USER_arr=(model1 model2)
PASS_arr=(model1 model2)

# 读取流水线写入的 IP
IPs=`cat IPs`
echo $IPs

# 分割 IP 为数组
IParr=(${IPs//[^0-9.]/ })
echo ${IPs//[^0-9.]/ }

for IP in ${IParr[@]}
do
  echo
  echo \# $IP

  DIR_arr=(`ls -d 2*/*/*/*`)

  for DIR in ${DIR_arr[@]}
  do
    echo
    echo \#\# cd $DIR
    cd $DIR

    for i in ${INDEX_arr[@]}
    do
      # -a -e 通用 -d 目录 -f 文件 -s 不为空 -z 为空 -r 可读 -w 可写 -x 可执行
      if [ ! -d "${SUB_DIR_arr[$i]}" ];then
        continue
      fi

      echo
      echo \#\#\# cd ${SUB_DIR_arr[$i]}
      cd ${SUB_DIR_arr[$i]}

      echo \#\#\# start ${USER_arr[$i]}/***@$IP:1521/ORCL @oracle_run.sql
#      sqlplus ${USER_arr[$i]}/${PASS_arr[$i]}@$IP:1521/ORCL @oracle_run.sql
        # -v 显示日志 -U 禁止无 where 更新
#        mysql -v -U -u${USER_arr[$i]} -p${PASS_arr[$i]} -h $IP -P 3306 --default-character-set=utf8mb4 < mysql_run.sql
      echo \#\#\# end ${USER_arr[$i]}/***@$IP:1521/ORCL @oracle_run.sql
      cd ..
    done
    cd ..
  done
done