# Java 运维

### -D 和参数名之间空一格

避免 IDE 拼写检查误判

### 从 class 查看 JDK 版本

Windows
```batch
javap -v Demo.class | finstr version
```

Linux
```sh
javap -v Demo.class | grep version
  minor version: 0
  major version: 52
od -x UniqueValidator.class |awk 'NR==1'
0000000 feca beba 0000 3400 7c01 000a 0062 07be
```

| version | Hex        | major       |
| ------- | ---------- | ----------- |
| 6       | 2 ^ 5 = 32 | 10 × 5 = 50 |
| 7       | 33         | 51          |
| 8       | 34         | 52          |


### 【推荐】`JVM`参数配置打印堆内存不足打印内存快照，若设置输出文件夹需存在，便于解决 OOM
堆文件 Dump .hprof(Heap Profile) 格式：java_pid*.hprof\
可以用 JDK 自带的 jvisualvm.exe 查看
```
-XX:+HeapDumpOnOutOfMemoryError
-XX:HeapDumpPath=../logs
```
较老的`tomcat`项目可以在`bin/catalina.sh`中配置
```shell
JAVA_OPTS="$JAVA_OPTS -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=../logs"
```


### 【推荐】测试环境开启远程调试

较老的`tomcat`项目可以编辑 tomcat/bin/catalina.sh\
把 localhost 改 0.0.0.0，否则 tomcat远程调试只能本机访问
```
if [ "$1" = "jpda" ] ; then
  if [ -z "$JPDA_TRANSPORT" ]; then
    JPDA_TRANSPORT="dt_socket"
  fi
  if [ -z "$JPDA_ADDRESS" ]; then
    JPDA_ADDRESS="localhost:8000"
  fi
```
重新启动
```
./shutdown.bat
./catalina.sh jpda start
```
（助记：java 的 j，pda掌上电脑)