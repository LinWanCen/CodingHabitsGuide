#!/bin/sh

moduleName=$1

pidPath="$(dirname "$0")/$moduleName-pid_record"

pid_record=$(cat "${pidPath}" | awk '{print $1}')
pid_record=$(ps -aef | grep "$pid_record" | awk '{print $2}' |grep "$pid_record")
if [ "$pid_record" ]; then
  kill "$pid_record"
fi