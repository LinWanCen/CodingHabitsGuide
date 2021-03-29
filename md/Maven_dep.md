# Maven dep 依赖

### 注意 Windows 不区分大小写，Linux 区分，必须写对

### 不应使用`systemPath`引用本地包

会使与他有关的项目难以编译


### `maven-compiler-plugin`添加`jar`路径时必须添加`${project.basedir}`，否则在`Linux`下会找不到包

3.1 前，注意这里是`compilerArguments`，后面有个`s`
```xml
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.0</version>
        <configuration>
          <compilerArguments>
            <extdirs>${project.basedir}/src/main/webapp/WEB-INF/lib</extdirs>
          </compilerArguments>
        </configuration>
      </plugin>
```
3.1 后
(最新 version 可以参考 http://maven.apache.org/plugins/maven-compiler-plugin/usage.html)
```xml
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.8.1</version>
        <configuration>
          <compilerArgs>
            <arg>-extdirs</arg>
            <arg>${project.basedir}/src/main/webapp/WEB-INF/lib</arg>
          </compilerArgs>
        </configuration>
      </plugin>
```

一些老旧的项目引用了`com.sun`的包，需要配置`-bootclasspath`，
并且确保 JAVA_HOME 环境变量指向的是有这些类的 Oracle JDK，而不是 openjdk，
可以参考 [Maven_sun/pom.xml](Maven_sun/pom.xml)


javac 参数参考：https://docs.oracle.com/javase/8/docs/technotes/tools/windows/javac.html

#### -bootclasspath 引导类路径
根据指定的引导类集交叉编译。与用户类路径一样，引导类路径条目由冒号（:)分隔，并且可以是目录，JAR归档文件或ZIP归档文件。

#### -extdirs 目录
针对指定的扩展目录进行编译。目录是目录的冒号(Windows 分号)分隔列表。将搜索指定目录中的每个 JAR 存档以搜索类文件。


#### -verbose
详细输出。这包括有关加载的每个类和编译的每个源文件的信息。

#### -Xlint:unchecked
为 Java 语言规范规定的未选中转换警告提供更多详细信息。

#### -deprecation
显示已弃用成员或类的每次使用或重写的说明。\
如果没有-deprecation，javac显示使用或重写弃用成员或类的源文件的摘要。\
-deprecation是 -Xlint:deprecation 的简写。


### 区分好“依赖问题”和“编译问题”

依赖问题：
```
Could not resolve dependencies for project 不能解析的依赖模块gav:
The following artifacts could not be resolved:
不能解析的模块gav1, 不能解析的模块gav2:
Could not find artifact 找不到的包gav in 远程仓库ID (远程仓库URL)
```

编译问题：
```
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 源文件数 source files to /路径/target/classes
[INFO] -------------------------------------------------------------
[WARNING] COMPILATION WARNING :
[INFO] -------------------------------------------------------------
 
 
...中间省略n行...
 
 
[ERROR] /路径/src/包路径/类名.java:[行,列] cannot find symbol
  symbol:   class 找不到的符号
  location: package 找不到的包
```

改了配置后因为缓存不下载包，是因为本地仓库有`.lastUpdated`和`_remote`文件，可以跑脚本删除目录下这些文件，或者运行时加`-U`参数。
```
was cached in the local repository,
resolution will not be reattempted until the update interval of 远程仓库ID has elapsed or updates are forced
```
[delete_lastUpdated_and_remote.sh](Maven/delete_lastUpdated_and_remote.sh)


### 仓库 id 不要重复，非中央仓库不应使用 central

镜像配置用于对特定的存储库使用备用镜像，而不更改项目文件，

`mirrorOf`对应`repositoryId`，可以设置为`*`或`central`。

假设配置`repository`时使用`central`作为`id`，那么就不能不同仓库用不同的 mirror。


### 仓库只下载稳定版本，需做好配置

仓库默认只下载稳定版本，如果 Nexus 代理是混合仓库的话需要在`pom.xml`或`settings.xml`中设置仓库快照为启用。

settings 镜像配置官方文档：https://maven.apache.org/settings.html#mirrors

settings 仓库配置官方文档：https://maven.apache.org/settings.html#repositories

settings.xml
```xml
<settings>
  <mirrors>
    <mirror>
      <id>mirrorId</id>
      <mirrorOf>company_or_app_name</mirrorOf>
      <name>Nexus</name>
      <url>http://my.repository.com/repository/company_or_app_name/</url>
    </mirror>
  </mirrors>

  <profiles>
    <profile>
      <id>company_or_app_name</id>
      <activation> <activeByDefault>true</activeByDefault> </activation>
      <repositories>
        <repository>
          <id>company_or_app_name</id>
          <name>Nexus</name>
          <url>http://my.repository.com/repository/company_or_app_name/</url>
          <releases>
            <enabled>true</enabled>
            <updatePolicy>always</updatePolicy>
            <checksumPolicy>warn</checksumPolicy>
          </releases>
          <snapshots>
            <enabled>true</enabled>
            <updatePolicy>always</updatePolicy>
            <checksumPolicy>warn</checksumPolicy>
          </snapshots>
        </repository>
      </repositories>
    </profile>
  </profiles>

</settings>
```

pom 仓库配置官方文档：https://maven.apache.org/pom.html#repositories

pom.xml
```xml
<project>
  <repositories>
    <repository>
      <id>company_or_app_name</id>
      <name>Nexus</name>
      <url>http://my.repository.com/repository/company_or_app_name/</url>
      <releases>
        <enabled>true</enabled>
        <updatePolicy>always</updatePolicy>
        <checksumPolicy>warn</checksumPolicy>
      </releases>
      <snapshots>
        <enabled>true</enabled>
        <updatePolicy>always</updatePolicy>
        <checksumPolicy>warn</checksumPolicy>
      </snapshots>
    </repository>
  </repositories>
</project>
```