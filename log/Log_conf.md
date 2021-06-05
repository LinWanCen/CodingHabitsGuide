## 日志配置指南


### 各个环境的配置要分离

禁止直接把生产环境的配置文件放在默认目录，
否则总有开发本地改个文件做自测然后不小心提交上去。

推荐使用配置中心管理，普通项目的话可以用例子里的 maven 配置，
在编译对应环境时传入`-P pro`这种方式启用对应环境的配置文件。

### 配置文件需设置动态修改配置扫描时间

使用 log4j2 和 logback 的官方文档示例值 30 秒，
这里的时间间隔太短怕有细微的性能消耗，太长的话运维修改需等待太久生效。

## Pattern

### pattern 和路径前后缀等多处重复的值配置为参数方便修改

### pattern 配置编码格式避免乱码

注：如果 IDEA 没配置 UTF-8 的话配置了反倒会乱码

### pattern 不要配置任何位置信息

位置信息指：
```
%C or $class
%F or %file
%l or %location
%L or %line
%M or %method
```
http://logging.apache.org/log4j/2.x/manual/async.html

### pattern 本地控制台输出`(%F:%L)`以便开发快速定位打印日志的位置（在 IDEA 中会形成链接）

### pattern 字段用制表符分割，时间采用 Excel 标准格式

在只需要看某些列时可以复制粘贴到 Excel 中，甚至根据时间等做透视表，方便分析。

```
%d{yyyy-MM-dd HH:mm:ss.SSS}\t%level\t%thread\t'%X{traceId}\t|\t%msg%n
```

如上，因数字太长粘贴到表格中会丢失精度。
加单引号后粘贴到 WPS 表格会自动转换为文本形式，在 Excel 若需要数字值可以分列为文本。

其中前面的时间、等级、线程名、跟踪号顺序固定，没有跟踪号的省略对应列。

后面可以加自定义的字段，不要加整个文件都一致的`'%X{filedName}`字段，在代码打印的消息`%msg`前加竖线列分割。

推送到日志归集服务时提供数据库分库编号、缓存实例、容器名、机器名、IP等信息


### 备份文件后面加 gz 压缩，减少磁盘空间消耗

### 配置启动时清理，避免从未触发滚动导致清理永远都不会被执行

cleanHistoryOnStart
http://logback.qos.ch/manual/appenders.html#tbrpCleanHistoryOnStart

log4j2
```xml
<Policies>
  <OnStartupTriggeringPolicy/>
  <TimeBasedTriggeringPolicy/>
  <SizeBasedTriggeringPolicy size="10 MB"/>
</Policies>
```

### 计算好日志最大磁盘占用，避免磁盘被占满

log4j2.xml：
http://logging.apache.org/log4j/log4j-2.8/manual/appenders.html#Log_Archive_Retention_Policy:_Delete_on_Rollover
`IfAccumulatedFileSize`的和
```xml
      <DefaultRolloverStrategy max="20">
        <Delete basePath="${baseDir}" maxDepth="4">
          <IfFileName glob="**/app.*.log.gz"/>
          <IfAny>
            <IfLastModified age="200d"/>
            <IfAccumulatedFileSize exceeds="5GB"/>
          </IfAny>
        </Delete>
      </DefaultRolloverStrategy>
```

logback.xml：
`<totalSizeCap>`的和


## log4j2 配置规范

### 使用 AsyncRoot/AsyncLogger，而不是 AsyncAppender，不能同时使用

### Root/Logger 不需要位置信息时可以配置`includeLocation="false"`，AsyncRoot/AsyncLogger 不需要

默认情况下，位置不会通过异步记录器传递给 I/O 线程
http://logging.apache.org/log4j/2.x/manual/async.html



## logback 配置规范

### 需要配置关闭钩子

官方文档没有写类名，实际会报错
https://jira.qos.ch/browse/LOGBACK-1090
```
<shutdownHook/>
<shutdownHook class="ch.qos.logback.core.hook.DelayingShutdownHook"/>
```


### AsyncAppender 的 neverBlock 不阻塞的情况下退出时日志会丢失

即使设置了钩子也会丢失
http://logback.qos.ch/manual/appenders.html#asyncNeverBlock


### 注意 logback 路径中非主要时间参数需要标记为辅助 aux

```
<property name="prefix" value="${baseDir}/%d{yyyy-MM, aux}/%d{yyyy-MM-dd}"/>
```
http://logback.qos.ch/manual/appenders.html#tbrpFileNamePattern
