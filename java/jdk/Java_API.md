# Java API

### 正则表达式应预编译

### `String.format`比直接+拼接效率低很多，应避免使用

### 使用 JVM 钩子优雅停机（断电或`kill -9`无效）

线程池需监听进程关闭：`Runtime.getRuntime().addShutdownHook()`