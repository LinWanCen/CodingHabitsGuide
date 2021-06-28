#!/bin/sh

## 目录结构 2021/01/01/00/mysql_run.sql

mkdir target

if [ 0"$grep" = "0" ]; then
  ls -rd 2*/*/*/* | head -1 |xargs -l -i cp {} target -frp --parent
else
  ls -d 2*/*/*/* |grep -E "$grep"|xargs -l -i cp {} target -frp --parent
fi

echo $IPs > target/IPs

zip -r target.zip target