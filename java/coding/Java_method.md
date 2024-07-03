## Java 方法

### 不应该在一个文件中有多个方法，除非方法之间没有依赖，或者由上到下依赖

在一个类中增加方法时应十分克制，鼓励添加而不是修改，体现开闭原则。

如果不能快速理直接清楚方法之间的关系那么方法关系就太复杂了


### 方法依赖的公共方法可以用包可见封装到多个文件中

包可见也便于单元测试


### get/set/is 仅用于 JavaBean 字段，便于通过这个开头识别


### 字段赋值方法不要放在业务程序里，避免影响主逻辑的阅读

```regexp
set([^(]++)\([^.]++\.get\1\(
```

### 使用 protected 而不是 private

1. private 不便于单元测试。
2. 体现对拓展开放，否则装饰者继承无法使用 private 的内容，就不得不复制代码。
3. Sonar 也是提示改成 protected 而不是 private。


### 养成 Utils 类第一句就 private 构造方法的习惯


### 预定义语句可以抽取成卫语句方法

```
String a;
if ... {
    a = ...
} else if {
    a = ... 
} else if {
    ...
```

抽取成：
```
String foo() {
if (...) {
    return ...
} else if {
    return ... 
} else if {
    ...
```

while 预定义除外

### switch 较多时抽取成方法，减少 break


### 修饰符按谷歌规范的顺序

```
public protected private abstract default static final transient volatile synchronized native strictfp
```

https://google.github.io/styleguide/javaguide.html#s4.8.7-modifiers

https://github.com/google/styleguide/blob/gh-pages/javaguide.html