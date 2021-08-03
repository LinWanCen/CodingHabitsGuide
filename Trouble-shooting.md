# 生产问题（线上故障）处理排查思路
未完成

## 相关文章

https://developer.aliyun.com/article/786091

## 应急
1. **汇报上级**，以便上级协调资源支持
2. 分析影响范围并立即**止损**（改状态禁登陆、止付、禁 IP 等），可能会随着分析加大
3. 按应急方案保留一些现场数据（如 jstack、CPU、内存）后尽快恢复（重启、回滚、限流、扩容）
4. Bug 应急思路: 改数据库 -> 改配置文件 -> 发程序补丁

## 原因

性能问题

类型 | 命令
--- | ---
CPU | top、vmstat、pidstat、ps
内存 | free、top、ps、vmstat、cachestat、sar
IO   | lsof、iostat、pidstat、sar、iotop、df、du
网络 | ifconfig、ip、nslookup、dig、ping、tcpdump、iptables

## 回顾

其他地方是否有类似问题？


