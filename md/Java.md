# Java

## 代码

### 常量数组和枚举单独成行，最后一项也加逗号
[https://github.com/alibaba/p3c/issues/563](https://github.com/alibaba/p3c/issues/563)


### 数字使用下划线增加可读性

JDK 7 中的新特性
```java
long a = 1_000_000L;
byte b = 0b0010_0101;
long maxLong = 0x7fff_ffff_ffff_ffffL;
```


### 修饰符按谷歌规范的顺序

```java
public protected private abstract default static final transient volatile synchronized native strictfp
```

[https://google.github.io/styleguide/javaguide.html#s4.8.7-modifiers](https://google.github.io/styleguide/javaguide.html#s4.8.7-modifiers)

[https://github.com/google/styleguide/blob/gh-pages/javaguide.html](https://github.com/google/styleguide/blob/gh-pages/javaguide.html)


### 不需要正则替换时优先使用`replace()`(也是替换所有)

`replaceAll()`和`split()`的参数是正则表达式

### 正则表达式应预编译

### `String.format`比直接+拼接效率低很多，应避免使用

### 使用 JVM 钩子优雅停机（断电或`kill -9`无效）



## 注释

### 使用文档注释，文档注释中使用`HTML`格式化，使用链接便于快速跳转查看

例如换行应该使用<br/>等

使用`{@link package.class＃member label}`便于在相关程序中快速跳转

测试案例链接到测试类应使用`@see`，不加`package`，使链接保持简短
```java
/**
 * @see Include
 */
public class IncludeTest {
```


### 不要在开发工具(`IDE`)中设置自动注释格式，只需做必要的注释。

设置自动注释格式而没有对应的内容时会在代码中留下很多无用的内容，
而且在`IntelliJ IDEA`中默认会报红提示。
好的代码在参数、返回字段等地方应该是不言自明的，
但是类似返回的值为空是哪些情况等需要说明的地方还是需要注释。


### 使用`// FIXME 测试挡板`标注临时代码

原则上不应编写临时挡板，如果是单次的可以用远程调试下编辑编译的方式单次热替换。

因为在某些项目中`IDE`生成的代码带有`TODO`标签，所以用`FIXME`，并且用中文让审核代码的同事也能一眼关注到



## 结构

### 按功能划分包而不是按层划分包

[https://phauer.com/2020/package-by-feature/](https://phauer.com/2020/package-by-feature/)


### 不应该在一个文件中有多个方法，除非方法之间没有依赖，或者由上到下依赖

方法依赖的公共方法可以用包可见封装到多个文件中，
包可见也便于单元测试


### 使用`package-info.java`配合文档注释说明包的作用



## 部署

### 【推荐】`JVM`参数配置打印堆内存不足打印内存快照，若设置输出文件夹需存在，便于解决OOM
堆文件 Dump .hprof(Heap Profile) 格式：java_pid*.hprof\
可以用 JDK 自带的 jvisualvm.exe 查看
```
-XX:+HeapDumpOnOutOfMemoryError
-XX:HeapDumpPath=../logs
```
较老的`tomcat`项目可以在`bin/catalina.sh`中配置
```shell
JAVA_OPTS="$JAVA_OPTS -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=../logs"
```

### 【推荐】测试环境开启远程调试

较老的`tomcat`项目可以编辑 tomcat/bin/catalina.sh\
把 localhost 改 0.0.0.0，否则 tomcat远程调试只能本机访问
```
if [ "$1" = "jpda" ] ; then
  if [ -z "$JPDA_TRANSPORT" ]; then
    JPDA_TRANSPORT="dt_socket"
  fi
  if [ -z "$JPDA_ADDRESS" ]; then
    JPDA_ADDRESS="localhost:8000"
  fi
```
重新启动
```
./shutdown.bat
./catalina.sh jpda start
```
（助记：java 的 j，pda掌上电脑)
