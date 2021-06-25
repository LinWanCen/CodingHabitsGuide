# 解决命令行左边显示 -bash-4.2$
cp /etc/skel/.bash* /home/$USER

# Linux终端断开秒数查看与修改
echo $TMOUT
su
vim /etc/profile
## 三个小时后断开，测试环境可以注释掉
export TMOUT=10800