# 数据库与 Java

### `@Transactional`不能用在`private`方法


### `prepareStatement`从`1`开始而不是`0`开始


### 调用外部服务与持有数据库连接不要放一起，否则调用时间较长时会导致长时间占用连接

而且在`SELECT ... FOR UPDATE`或`UPDATE`后会导致长时间锁表


### 阿里 Druid 连接池即使数据库连接超时释放了，连接池连接没释放也会导致性能问题，必须注意连接的释放

排查方法：
```xml
<!-- 超过时间限制是否回收 -->  
<property name="removeAbandoned" value="true" />  
<!-- 超时时间；单位为秒，180秒=3分钟   -->
<property name="removeAbandonedTimeout" value="180" />  
<!-- removeAbandoned 打印堆栈 -->
<property name="logAbandoned" value="true" />
```
日志里查找 removeAbandoned 找到错误堆栈


