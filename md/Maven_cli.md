# Maven cli 命令行

命令行参数官方文档：http://maven.apache.org/ref/3.6.3/maven-embedder/cli.html


### 命令加上`-V`打印 Maven 版本和 JDK 版本，便于查问题

例如前面提到的某些`com.sun`的包只有 Oracle JDK 有


### RELEASE 版本的代码不要修改，编译时命令加上`-U`

其他机器一旦本地有 RELEASE 的包，即使服务器上的更新了也不会下载，即使加了`-U`，可能出现生产依赖的包没更新的问题。

SNAPSHOT 的包默认每天更新一次，加上`-U`防止出现依赖的包没更新的问题。

pom 仓库配置官方文档：https://maven.apache.org/pom.html#repositories
```
-U,--update-snapshots 强制检查远程存储库上是否有 本地缺少的发行版 和 新的快照版
```