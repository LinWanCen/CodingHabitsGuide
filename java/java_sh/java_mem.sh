# 空闲内存
free -h

# 解决 Error attaching to process: sun.jvm.hotspot.debugger.DebuggerException 管理员运行
echo 0 | tee /proc/sys/kernel/yama/ptrace_scope

# 检查 运行中的 java 配置最大总内存 管理员运行
# 小版本不一致会导致报错
# sun.jvm.hotspot.debugger.DebuggerException:
# sun.jvm.hotspot.runtime.VMVersionMismatchException:
# Supported versions are 25.201-b26. Target VM is 25.201-b09
jps | grep -v Jps | awk '{print $1}' | xargs -i jinfo {} | sed -n 's/.*MaxHeapSize=\([0-9]*\) .*/\1/p' | awk '{a+=$1}END{print a/1024/1024/1024}'

# 检查 默认内存
java -XX:+PrintFlagsFinal -version | grep MaxHeapSize

# 检查 配置内存
find . -name "*.sh" | xargs grep "\-Xmx"

# 检查 配置内存溢出时生成快照
find . -name "*.sh" | xargs grep "\-HeapDumpOnOutOfMemoryError"
