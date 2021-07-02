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
    JVM_MEM=`echo "$INFO" | sed -n 's/.*Xmx\([0-9]*\)[Mm].*/\1/p'`
    JVM_MEM=$((JVM_MEM * 1024 * 1024))
    if [ "$JVM_MEM" = 0 ] ; then
      JVM_MEM=`echo "$INFO" | sed -n 's/.*Xmx\([0-9]*\)[Gg].*/\1/p'`
      JVM_MEM=$((JVM_MEM * 1024 * 1024 * 1024))
    fi
    if [ "$JVM_MEM" = 0 ] ; then
      JVM_MEM=`$JAVA -XX:+PrintFlagsFinal -version | grep MaxHeapSize | sed -n 's/.*= \([0-9]*\) .*/\1/p'`
    fi
  fi
  echo `echo "${JVM_MEM}" | awk '{print $1/1024/1024/1024" GB"}'` $J_INFO `echo "$JPS" | grep $PID`
  JVM_MEM_SUM=$((JVM_MEM_SUM+=JVM_MEM))
done
echo "`echo "${JVM_MEM_SUM}" | awk '{print $1/1024/1024/1024" GB"}'`"

TOTAL_MEM=`free|grep Mem|awk '{print $2*1024}'`
echo TOTAL_MEM: "`echo "${TOTAL_MEM}" | awk '{print $1/1024/1024/1024" G"}'`"

free -h

if [ $JVM_MEM_SUM -ge $TOTAL_MEM ]; then
  exit 1
fi