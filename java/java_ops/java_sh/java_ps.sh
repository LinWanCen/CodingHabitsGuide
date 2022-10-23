# JAVA 进程，-l 启动类或包 -m 方法参数 -v JVM参数 -q 只显示 PID
jps -mlvV | grep -v Jps

# 进程时间 标题
ps -ef | head -1 | grep -v grep
#  UID        PID  PPID  C STIME TTY          TIME CMD

# 进程CPU和内存 标题
ps aux | head -1 | grep -v grep
# USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
# 其中STAT状态位常见的状态字符有
# S | 处于休眠状态
# R | 正在运行可中在队列中可过行的
# l | 多线程
# + | 位于后台的进程组
# D | 无法中断的休眠状态，通常是 IO
# T | 停止或被追踪
# Z | 僵尸进程

# 进程时间
ps -ef | grep java | grep -v grep

# 进程CPU内存与时长，COMMAND 可能被截断影响 grep
ps aux | grep java | grep -v grep

# 停止应用后修正用户
chown -R admin:admin /home/admin

# 启动目录
readlink -f /proc/$PID/cwd

# 启动程序位置
readlink -f /proc/$PID/exe