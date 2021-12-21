# 查询

### selectOne 必须命中唯一索引

根据墨菲定律，如果不限制总会有脏数据导致查出多条导致报错

### 大规模查询下`WHERE`/`ON`的字段需要命中索引

写数据库语句时看表结构是个好习惯，如果没有命中需注释说明原因。

索引是从左到右匹配，\
即多列索引要前面的存在才能匹配后面的，跟 WHERE 顺序无关，\
在索引中 XXX% 能匹配，而 %XXX不能匹配


### MySQL 跟 Oracle/PostgreSQL 不同，行锁须命中索引，没有命中会锁表


### 避免动态`SQL`里出现全表查询

动态`SQL`没有预编译，性能本身就不好，但是在一些表筛选中难免会用到。\
一般系统都会要求某个条件必选，因为有时候用户没有选任何条件就会出现全表查询导致系统卡顿。\
同样在前后端都需要做判断，前端可能漏传错传条件导致触发全表查询，测试环境数据较少可能发现不了问题。


### 带筛选的查询功能刚进入时不要默认查询，除非能保障性能

例如作业执行清单，很多时候进去是要查指定作业，\
如果进去后默认显示最近作业，又没有充分优化，就可能需要卡一会儿


### 数据量大的查询需使用游标查询，并使用流式读，避免 数据库服务器表空间爆满 和 程序(堆)内存不足错误

`OOM: OutOfMemoryError`(堆)内存不足错误，对应`SOF: StackOverflowError`栈溢出错误

xml写法：
```xml
  <!-- fetchSize="-2147483648" 是 流式读 避免 数据库服务器表空间爆满 和 程序堆内存不足错误 -->
  <select id="" fetchSize="-2147483648">
    SELECT * FROM TEST_TABLE
  </select>
```

注解写法：
```java
@Mapper
class demo {
    /**
     * 调用需要加 @Transactional 注解，否则会立即关闭连接导致游标报 A Cursor is already closed.
     * <br>fetchSize="-2147483648" 是 流式读 避免 数据库服务器表空间爆满 和 程序堆内存不足错误
     */
    @Options(fetchSize = Integer.MIN_VALUE)
    @Select("SELECT * FROM TEST_TABLE")
    Cursor<Map<String, String>> cursorAll();
}
```
