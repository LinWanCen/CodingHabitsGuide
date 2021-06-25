#!/bin/sh
# 避免 Oracle 乱码
export NLS_LANG="AMERICAN_AMERICA.AL32UTF8"

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

  DIR_arr=(`ls -rd 20*`)

  for DIR in ${DIR_arr[@]}
  do
    echo
    echo \#\# cd $DIR
    cd $DIR

    for i in 0 1 2 3
    do
      if [ ! -d "${SUB_DIR_arr[$i]}" ];then
        continue
      fi

      echo
      echo \#\#\# cd ${SUB_DIR_arr[$i]}
      cd ${SUB_DIR_arr[$i]}

      echo \#\#\# start ${USER_arr[$i]}/***@$IP:1521/ORCL @oracle_run.sql
#      sqlplus ${USER_arr[$i]}/${PASS_arr[$i]}@$IP:1521/ORCL @oracle_run.sql
        # -v 显示日志 -U 禁止无 where 更新
#        mysql -v -U -u${USER_arr[$i]} -p${PASS_arr[$i]} -h $IP -P 3306 < mysql_run.sql
      echo \#\#\# end ${USER_arr[$i]}/***@$IP:1521/ORCL @oracle_run.sql
      cd ..
    done
    cd ..
  done
done