# Java 运维

JAVA 命令官方文档：
https://docs.oracle.com/en/java/javase/16/docs/specs/man/java.html#advanced-options-for-java

JDK 工具官方文档：
https://docs.oracle.com/en/java/javase/16/docs/specs/man/index.html

Java 故障排除官方文档：
https://docs.oracle.com/en/java/javase/16/troubleshoot/general-java-troubleshooting.html



### Maven 的 -D 和参数名之间空一格

避免 IDE 拼写检查误判，但是 JVM 参数不能加空格而且必须放在 -jar 前面

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

hprof 文件另外一种获得方式：
```shell
jmap -dump:[live,]format=b,file=<filename>
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


## 使用 Oracle JDK 或者自装 jstack 等工具

否则到查问题的时候发现 Open JDK 默认没有相关工具就很麻烦

```shell
# 找到占用CPU的进程PID
top
# 找到占用CPU的线程PID
top -Hp $PID
# 把线程PID转换为16进制
printf "%x\n" $SUB_PID
# 找到线程堆栈并保存文本
jstack -l $PID | grep $SUB_PID_16 -A 30
# 或者直接保存完整jstack
jstack -l $PID >> jstack.txt
```