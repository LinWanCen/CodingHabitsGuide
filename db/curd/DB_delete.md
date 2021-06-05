# 删除

### 对表做特殊修改时应做备份，删除表可以用重命名的方式，慎用`TRUNCATE`(因为是`DDL`语句没有事务)

`Oracle`中`insert ... select`需用注释提高性能
```sql
insert ... select /*+ no_merge(p) use_hash(p) */  ...
```

`PostgreSQL`事务可以包含`DML`、`DDL`、`DCL`，可以使用重命名表的方式备份清理表不影响业务