# 事务


## ACID
- 原子性 atomicity
- 一致性 consistency
- 隔离性 isolation
- 持久性 durability


## 隔离级别
| 隔离级别    | 脏读 | 不可重读 | 幻读 | 英文名           | 默认  |
| ----------- | ---- | -------- | ---- | ---------------- | ----- |
| RU 读未提交 | √    | √        | √    | Read uncommitted |       |
| RC 读已提交 | ×    | √        | √    | Read committed   | 其他  |
| RR 可重读   | ×    | ×        | √    | Repeatable read  | MySQL |
| S  串行化   | ×    | ×        | ×    | Serializable     |       |

- 读未提交 = 脏读，没有隔离性，Saga 分布式事务的缺点
- 读已提交 = 不可重读：更新，一个事务两次读取内容不一样
- 幻读：插入，一个事务两次读取条数不一样，MySQL 用 MVCC 解决
- 多版本并发控制 MVCC Multiversion Concurrency Control
    - DB_TRX_ID 最近增改事务ID
    - DB_ROLL_PTR 回滚指针，上一版本 0x...
    - DB_ROW_ID 自增ID，没有主键时的聚簇索引
    - DELETED_BIT 删除


## CAP
- 一致性 Consistency
- 可用性 Availability
- 分区容错性 Partition tolerance
一般要求AP，C只需要保证最终一致性


## CAS
Check And Set


## 与缓存一致性
- 先更新数据库，避免刚删完缓存就被其他线程刷入旧数据
- 缓存使用删除而不是更新，避免更新时数据库内容已经变了


## Redis 事务

| Redis   | MySQL    |
| ------- | -------- |
| multi   | begin    |
| exec    | commit   |
| discard | rollback |
| watch   | (lock)   |


## 分布式锁

| 问题 | 数据库        | Redis                    | Zookeeper                    |
| ---- | ------------- | ------------------------ | ---------------------------- |
| 实现 | insert delete | set 键 id ex 秒 nx       |                              |
| 异常 |               | 靠ex                     | 客户端挂掉时节点就自动删除了 |
| 阻塞 | 轮询          | 轮询                     | 顺序创建、通知               |
| 重入 |               | MAC + jvm进程ID + 线程ID | 与当前最小节点对比           |
| 单点 |               | 集群部署                 | 集群部署                     |