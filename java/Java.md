# Java API

### 不需要正则替换时优先使用`replace()`(也是替换所有)

`replaceAll()`和`split()`的参数是正则表达式

### 正则表达式应预编译

### `String.format`比直接+拼接效率低很多，应避免使用

### 使用 JVM 钩子优雅停机（断电或`kill -9`无效）