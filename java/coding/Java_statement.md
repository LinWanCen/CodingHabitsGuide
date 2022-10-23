## Java 语句


### 除了流创建以外，每一步处理应单独成行

### ? : && || 除非特别短，否则应单独成行，并且把符号放在新行代码前面

### 常量数组和枚举单独成行，最后一项也加逗号

https://github.com/alibaba/p3c/issues/563


### 返回集合的语句抽成变量单独成行方便调试

for 循环、addAll 等情况在调试时不用执行表达式就能看 size 和内容


### 检查报错条件抽成变量方便调试时修改值

```
boolean isMatch = a && b || c;
if (!isMatch) { // 这里打条件断点`(isMatch = true) && false`不报错且不停下来
    throw BussinessException("SSO_0001");
}
```


### 数字使用下划线增加可读性

JDK 7 中的新特性
```
long a = 1_000_000L;
byte b = 0b0010_0101;
long maxLong = 0x7fff_ffff_ffff_ffffL;
```
