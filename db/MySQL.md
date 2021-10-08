# MySQL

- MyISAM：无事务、锁表、读写互相阻塞、索引不缓存数据、数据与索引分离，都是【非聚集索引】
- InnoDB：有事务，默认用主键or唯一非空列or隐藏列建立【聚集索引】（只能有一个），索引和数据在同一个B（平衡）树，影响增改性能，速度快，特性如下：
  - 插入缓冲（insert buffer）
  - 两次写（double write）
  - 自适应哈希索引(adaptive hash index,AHI)
  - 异步IO（asynchronous IO，AIO）
  - 刷新邻接页（flush neighbor page）

稠密索引、稀疏索引

- 回表查询：先在非聚集索引上查询到主键值，然后拿着主键值回到表里查聚簇索引
- 索引覆盖：返回字段在多列索引中可以避免回表查询，explain 的 extra 为 using index