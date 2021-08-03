# 比 netstat 更快的 ss, 若没有可以安装
yum install iproute iproute-doc

# -n 不用域名
# -p 进程（在 Windows 是协议），Windows 用 -o 显示 PID 当不能显示进程名
# -t 只 TCP
# -u 只 UDP
# -l 只监听无IP（Windows 没有）

# 下面的命令换成 netstat 也可以
# netstat Windows 也可以用, grep 用 findstr

# 端口进程
ss -lntp | grep java

# 端口匹配进程
ss -lntp | grep java | awk -F '[ ,=:]+' '{print $4,$9}' > /tmp/port.log && ps -ef | grep java > /tmp/ps.log && sort -k 2 /tmp/port.log -o /tmp/port.log && sort -k 2 /tmp/ps.log -o /tmp/ps.log && join /tmp/port.log /tmp/ps.log -1 2 -2 2

# 连接最多的 10 个 IP 端口
ss -ntu | awk '{print $5}' | sort | uniq -c | sort -nr | head -n 10

# 连接最多的 10 个 IP
ss -ntu | awk -F '[: ]*' '{print $6}'| sort | uniq -c | sort -nr | head -n 10