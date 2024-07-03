# Maven cli 命令行

命令行参数官方文档：http://maven.apache.org/ref/3.6.3/maven-embedder/cli.html


### 命令加上`-V`打印 Maven 版本和 JDK 版本，便于查问题

例如前面提到的某些`com.sun`的包只有 Oracle JDK 有


### RELEASE 版本的代码不要修改，编译时命令加上`-U`

其他电脑或服务器一旦本地仓库有 RELEASE 的包，即使远程仓库上的更新了也不会下载，即使加了`-U`，可能出现依赖的包没更新的问题。

SNAPSHOT 的包默认每天更新一次，加上`-U`防止出现依赖的包没更新的问题。

pom 仓库配置官方文档：https://maven.apache.org/pom.html#repositories
```
-U,--update-snapshots 强制检查远程存储库上是否有 本地缺少的发行版 和 新的快照版
```

### 如果不执行测试，编译也同时忽略，提高效率
```shell
# 不执行单元测试，也不编译测试类
-Dmaven.test.skip=true
# 不执行单元测试，但会编译测试类
mvn install -DskipTests=true
```
```xml
<properties>
  <!-- 不执行单元测试，但会编译测试类 -->
  <skipTests>true</skipTests>
  <!-- 不执行单元测试，也不编译测试类 -->
  <maven.test.skip>true</maven.test.skip>
</properties>
```
