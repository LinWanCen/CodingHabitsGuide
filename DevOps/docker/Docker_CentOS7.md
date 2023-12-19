# Docker CentOS 7 常用设置

### centos8 停止维护，所以下 7
```
docker pull centos:centos7
```
阿里云yum（centos7不用也行）：http://mirrors.aliyun.com/repo/

### 特权启动设置时区
避免报错 Failed to get D-Bus connection: Operation not permitted
```
docker run -d --name centos7 --privileged=true centos:centos7 /usr/sbin/init -e TZ=Asia/Shanghai
```

### 同步阿里云时间
```
timedatectl set-timezone Asia/Shanghai
yum install ntpdate -y
ntpdate ntp.aliyun.com
```

### 安装 locate 命令并初始化
```
yum install mlocate -y
updatedb
```

### 别自己编译 gcc，会遇到很多问题
安装并切换到 gcc 11 环境
```
yum install -y http://mirror.centos.org/centos/7/extras/x86_64/Packages/centos-release-scl-rh-2-3.el7.centos.noarch.rpm
yum install -y http://mirror.centos.org/centos/7/extras/x86_64/Packages/centos-release-scl-2-3.el7.centos.noarch.rpm
yum install devtoolset-11-gcc-c++
scl enable devtoolset-11 bash
```
如果以后都用 gcc 11 可以改下链接
```
mv /usr/bin/gcc /usr/bin/gcc-4.8.5
ln -s /opt/rh/devtoolset-11/root/bin/gcc /usr/bin/gcc
```