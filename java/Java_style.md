# Java Style 代码风格

### 创建类前先搜下类名是否被使用，尽量不要重复

- 创建前查找
- 类名重复查找时难以分辨

### 在类上打`@author`注释，多个作者时打多个
虽然 Git 或 Svn 能精确 blame，但是在没必要精确的工具中方便直接读`@author`判断作者

### 返回集合的语句单独成行方便调试

for 循环、addAll 等情况在调试时不用执行表达式就能看 size 和内容

### 除了流创建以外，每一步处理应单独成行

### ? : && || 除非特别短，否则应单独成行，并且把符号放在新行代码前面


### 常量数组和枚举单独成行，最后一项也加逗号
https://github.com/alibaba/p3c/issues/563


### 数字使用下划线增加可读性

JDK 7 中的新特性
```
long a = 1_000_000L;
byte b = 0b0010_0101;
long maxLong = 0x7fff_ffff_ffff_ffffL;
```


### 修饰符按谷歌规范的顺序

```
public protected private abstract default static final transient volatile synchronized native strictfp
```

https://google.github.io/styleguide/javaguide.html#s4.8.7-modifiers

https://github.com/google/styleguide/blob/gh-pages/javaguide.html