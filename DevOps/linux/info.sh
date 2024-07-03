# 查看物理CPU个数
cat /proc/cpuinfo | grep "physical id" | sort| uniq| wc -l

# 查看每个物理CPU中core的个数(即核数)
cat /proc/cpuinfo | grep "cpu cores" | uniq

# 查看逻辑CPU的个数
cat /proc/cpuinfo | grep "processor" | wc -l

# 查看CPU信息（型号）
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c

# 内存
free -h

# 硬盘
df -h

# 目录占用
du -sh *

# 目录总占用
du -ch *

# 主机名（命令行左边即 用户名@主机名）
hostnamelog

# IP
hostname -i

# CentOS 版本
cat /etc/redhat-release