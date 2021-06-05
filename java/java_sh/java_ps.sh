# 进程时间 标题
ps -ef | head -1
#  UID        PID  PPID  C STIME TTY          TIME CMD

# 进程CPU和内存 标题
ps aux | head -1
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
ps -ef | grep java

# 进程CPU内存与时长
ps aux | grep java

# 停止应用后修正用户
chown -R admin:admin /home/admin
