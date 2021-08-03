# 解决 Error attaching to process: sun.jvm.hotspot.debugger.DebuggerException 管理员运行
echo 0 | tee /proc/sys/kernel/yama/ptrace_scope

JPS=`jps -mlvV | grep -v Jps`

JVM_MEM_SUM=0
for PID in `echo "$JPS" | awk '{print $1}'`
do
  JAVA=`readlink -f /proc/$PID/exe`
  J_INFO=`echo $JAVA | sed 's/java$/jinfo/'`
  INFO=`$J_INFO $PID`
  JVM_MEM=`echo "$INFO" | sed -n 's/.*MaxHeapSize=\([0-9]*\) .*/\1/p'`
  if [ 0"$JVM_MEM" = 0 ] ; then
    # JDK 7 没有 MaxHeapSize，查设置
    JVM_MEM=`echo "$INFO" | sed -n 's/.*Xmx\([0-9]*\)[Mm].*/\1/p'`
    JVM_MEM=$((JVM_MEM * 1024 * 1024))
    if [ "$JVM_MEM" = 0 ] ; then
      # GB 时转换不一样所以另外查
      JVM_MEM=`echo "$INFO" | sed -n 's/.*Xmx\([0-9]*\)[Gg].*/\1/p'`
      JVM_MEM=$((JVM_MEM * 1024 * 1024 * 1024))
    fi
    # 若没有就用 JAVA 默认内存
    if [ "$JVM_MEM" = 0 ] ; then
      JVM_MEM=`$JAVA -XX:+PrintFlagsFinal -version | grep MaxHeapSize | sed -n 's/.*= \([0-9]*\) .*/\1/p'`
    fi
  fi
  # 显示时转换为 GB
  echo `echo "${JVM_MEM}" | awk '{print $1/1024/1024/1024" G"}'` $J_INFO `echo "$JPS" | grep $PID`
  # 单位是 b
  JVM_MEM_SUM=$((JVM_MEM_SUM+=JVM_MEM))
done

# 显示 jvm 内存总需求
echo "`echo "${JVM_MEM_SUM}" | awk '{print $1/1024/1024/1024" G"}'`"

# 机器内存默认 k 为单位，所以要 * 1024
TOTAL_MEM=`free|grep Mem|awk '{print $2*1024}'`
# 显示机器总内存
echo TOTAL_MEM: "`echo "${TOTAL_MEM}" | awk '{print $1/1024/1024/1024" G"}'`"

# 机器交换空间默认 k 为单位，所以要 * 1024
TOTAL_SWAP=`free|grep Swap|awk '{print $2*1024}'`
# 显示机器总交换空间
echo TOTAL_SWAP: "`echo "${TOTAL_SWAP}" | awk '{print $1/1024/1024/1024" G"}'`"

free -h

if [ $JVM_MEM_SUM -ge $[$TOTAL_MEM + $TOTAL_SWAP] ]; then
  exit 2
fi

if [ $JVM_MEM_SUM -ge $TOTAL_MEM ]; then
  exit 1
fi