# Linux 使用规范

### 全局环境变量应在`/etc/profile.d`添加文件设置而不是修改`/etc/profile`

JAVA_HOME.sh
```sh
export JAVA_HOME=/opt/jdk1.8.0_201
export PATH=$JAVA_HOME/bin:$PATH
```

