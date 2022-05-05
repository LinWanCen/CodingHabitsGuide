# Java log 日志与报错

### 日志输出的级别需经过思考，为什么要输出，为什么选这个级别，注释说明特殊考虑。

人工介入 error，自动处理 warn，关键过程 info，排查问题 debug，跟踪变量 trace

info 级别下的输出应该是比较干净的，可以降级的都降级，不降级的注释为什么

例如对排查某个外部问题有什么帮助、某个 info 可以观察长时间运行服务的关键过程和进度

实际开发中一开始可以多写日志，通过配置文件设置指定类 debug 级别，自测修好 bug 准备提交前就应该删减降级

实际运行检查每个级别的日志量

全文搜索每个级别的代码量

```regexp
\.(trace|debug|info|warn|error)\([^;]*;
\.(trace)\([^;]*;
\.(debug)\([^;]*;
\.(info)\([^;]*;
\.(warn)\([^;]*;
\.(error)\([^;]*;
```


### 应使用占位符{}，而不是字符串拼接
排查正则
```regexp
\.(trace|debug|info|warn|error)[^;+]*\+[^;]*;
```


### 输出文件路径可以前面加`file:///`，并使用左斜杠（在 IDEA 控制台中会形成链接）

[PathUtils.java](PathUtils.java)


### 不使用`System.out`、`System.err`、`printStackTrace`
替换正则
```
// 一般这种方式打印的都是为了排错，所以用 debug
System\.out\.print(?:ln)?([^;]*);
LOG.debug$1; // Replace All sout

// 这里根据实际情况选择 error 或 warn
System\.err\.print(?:ln)?([^;]*);
LOG.warn$1; // Replace All serr

// 既然不是 throw 而是输出日志，那么应该不用人工介入，所以用 warn
// 避免大规模 error 日志又难以设置掉而堆满磁盘
\b(\w+)\.printStackTrace\(\);
LOG.warn("", $1); // Replace All pst
```

报错类补充成员变量(IDEA 模板)
```
private static final org.slf4j.Logger LOG = org.slf4j.LoggerFactory.getLogger($thisClass$.class);
```
thisClass: className()


### SQL 日志可以帮助查询导致数据变化的原因

查询数据库记录更新时间对应的 update xxx 的日志排查问题