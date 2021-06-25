#!/bin/sh
mkdir target

if [ 0"$grep" = "0" ]; then
  ls -rd 20*/* | head -1 |xargs -l -i cp {} target -frp --parent
else
  ls -d 20*/* |grep -E "$grep"|xargs -l -i cp {} target -frp --parent
fi

echo $IPs > target/IPs

zip -r target.zip target