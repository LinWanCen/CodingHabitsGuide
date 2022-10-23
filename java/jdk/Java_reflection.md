# Java 反射

### 类的分类和类型

在`Class.getEnclosingClass()`方法可以看到类分为 5 种
- 顶级 Top level classes
- 嵌套 Nested classes (static member classes)
- 内部 Inner classes (non-static member classes)
- 本地 Local classes (named classes declared within a method)
- 匿名 Anonymous classes

从`Type`的子类/接口可以看到类类型也分 5 种
- Class（子类，其他都是接口）
- GenericArrayType []/...
- ParameterizedType <>
- TypeVariable T
- WildcardType ?


### 显示类名可能是数组时用`getTypeName`(Exception不会是数组)

关于`className`的方法有四个
- getSimpleName 匿名时空串
- getName 数组时`[L类名;`
- getTypeName 内部/匿名时`$`
- getCanonicalName 内部/匿名时`null`

- Class.forName 用的是 getName 获得的
- 原生类型不能用 forName
- 原生类型数组大多数是用首字母如`int[].class`就是`[I`，注意末尾没分号
- `boolean[].class`是`[Z`，`long`类型是`[J`

### 方法调用类型

下面的`~`为`invoke`的简写
- S ~static    静态
- O ~special   私有/构造/super
- M ~virtual   实例(可重写)
- I ~interface 实现(应重写)
- D ~dynamic   lambda
main 方法可以继承运行，不算重写（不能`@Override`）

### 使用 JDK 自带的类来做解析工具的接口返回

一些常量或类型可以用诸如`Modifier`、`ElementType`的定义