#!/bin/sh

moduleName=$1
pidPath="$(dirname "$0")/$moduleName-pid_record"

if [ -f "$myFile" ]; then
  pid_record=$(cat "${pidPath}" | awk '{print $1}')
  pid_record=$(ps -aef | grep "$pid_record" | awk '{print $2}' |grep "$pid_record")
  if [ "$pid_record" ]; then
    kill -9 "$pid_record"
  fi
  rm -f "$pidPath"
fi

# nohup 结果输出到nohup.out 免疫关闭session发送SIGHUP信号
# & 结果输出到终端 免疫Ctrl + C发送SIGINT信号
# 两者结合免疫SIGINT和SIGHUP信号
nohup java -jar $(dirname "$0")/$moduleName.jar > ./$moduleName.log 2>&1 &

echo $! > "$pidPath"