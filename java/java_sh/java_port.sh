# 端口进程
ss -tnlp | grep java

# 端口匹配进程
ss -tnlp | grep java | awk -F '[ ,=:]+' '{print $4,$9}' > /tmp/port.log && ps -ef | grep java > /tmp/ps.log && sort -k 2 /tmp/port.log -o /tmp/port.log && sort -k 2 /tmp/ps.log -o /tmp/ps.log && join /tmp/port.log /tmp/ps.log -1 2 -2 2

