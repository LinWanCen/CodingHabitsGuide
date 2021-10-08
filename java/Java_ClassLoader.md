# 自定义类加载

- BootstrapClassLoader 启动类加载器
  C++编写，加载java核心库 java.*,构造ExtClassLoader和AppClassLoader。
  由于引导类加载器涉及到虚拟机本地实现细节，开发者无法直接获取到启动类加载器的引用，所以不允许直接通过引用进行操作

- ExtClassLoader 标准扩展类加载器
  java编写，加载扩展库，如classpath中的jre ，javax.*或者
  java.ext.dir 指定位置中的类，开发者可以直接使用标准扩展类加载器。

- AppClassLoader 应用类加载器

- CustomClassLoader 用户自定义类加载器

## 双亲委派机制（翻译问题，应该叫父类委派）

先从下往上确认是否已经加载过，再从上往下确认是否可以加载