# Maven_pom

### 中文团队下项目需添加名称标签 `<name>${project.artifactId} | 简称1 | 简称2</name>`

简称可以是中文或英文，这样在`Maven`日志、`SonarQube`报告、`IDEA`侧边栏等显示都更为友好

根据官方文档 https://maven.apache.org/pom.html#more-project-information

```xml
<project>
  <name>开发们常用的简称</name>
  <description>核心功能和在整个架构中的作用</description>
  <inceptionYear>成立年份</inceptionYear>
  <url>链接</url>
</project>
```

`Spring Boot`
```xml
<project>
  <artifactId>spring-boot-starter-parent</artifactId>
  <name>Spring Boot Starter Parent</name>
  <description>Parent pom providing dependency and plugin management for applications built with Maven</description>
</project>
```


### 设置 Java 版本和编码，避免乱码和编译失败

```xml
  <properties>
    <java.version>1.8</java.version>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
    <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>

    <maven.compiler.encoding>UTF-8</maven.compiler.encoding>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
  </properties>
```

spring-boot-starter-parent 里仅对必要的做了设置，框架源代码如下
```xml
  <properties>
    <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
    <java.version>1.8</java.version>
    <resource.delimiter>@</resource.delimiter>
    <maven.compiler.source>${java.version}</maven.compiler.source>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.target>${java.version}</maven.compiler.target>
  </properties>
```


### 不应使用`systemPath`引用本地包

会使与他有关的项目难以编译


### `maven-compiler-plugin`添加`jar`路径时必须添加`${project.basedir}`，否则在`Linux`下可能会找不到包

3.1 前，注意这里是`compilerArguments`，后面有个`s`
```xml
      <plugin>
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
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.8.1</version>
        <configuration>
          <compilerArgs>
            <arg>-verbose</arg>
            <arg>-Xlint:unchecked</arg>
            <arg>-Xlint:deprecation</arg>
            <arg>-extdirs</arg>
            <arg>${project.basedir}/src/main/webapp/WEB-INF/lib</arg>
          </compilerArgs>
        </configuration>
      </plugin>
```
参数参考：https://docs.oracle.com/javase/8/docs/technotes/tools/windows/javac.html

#### -verbose
详细输出。这包括有关加载的每个类和编译的每个源文件的信息。

#### -Xlint:unchecked
为 Java 语言规范规定的未选中转换警告提供更多详细信息。

#### -deprecation
显示已弃用成员或类的每次使用或重写的说明。\
如果没有-deprecation，javac显示使用或重写弃用成员或类的源文件的摘要。\
-deprecation是 -Xlint:deprecation 的简写。

#### -extdirs directories
针对指定的扩展目录进行编译。目录是目录的分号分隔列表。将搜索指定目录中的每个 JAR 存档以搜索类文件。

### 使用`profile`配合`resource`的`filter`对不同环境做不同配置，大多数配置应在配置平台

```xml
<project>
  <properties>
    <maven.resources.overwrite>true</maven.resources.overwrite>
  </properties>

  <build>
    <resources>
      <resource>
        <directory>${basedir}/src/main/resources</directory>
      </resource>
      <resource>
        <directory>${basedir}/src/main/resources_${envSuffix}</directory>
      </resource>
    </resources>
  </build>

  <profiles>
    <profile>
      <id>dev</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <properties>
        <envSuffix>dev</envSuffix>
      </properties>
    </profile>

    <profile>
      <id>sit</id>
      <properties>
        <envSuffix>sit</envSuffix>
      </properties>
    </profile>

    <profile>
      <id>pro</id>
      <properties>
        <envSuffix>pro</envSuffix>
      </properties>
    </profile>
  </profiles>
</project>
```


### 聚合项目和父项目是不同的概念，聚合项目对 module 是没有影响的，可以创建聚合项目优化编译打包结构

https://maven.apache.org/pom.html#A_final_note_on_Inheritance_v._Aggregation

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>io.github.linwancen.demo</groupId>
  <artifactId>log-demo-pom</artifactId>
  <version>1.0.0-SNAPSHOT</version>
  <name>${project.artifactId} | 日志演示聚合项目</name>
  <description>用于一起编译，不要以此为父项目</description>

  <packaging>pom</packaging>

  <modules>
    <module>log4j2-demo</module>
    <module>logback-demo</module>
  </modules>

  <!-- skip all and remove warn -->
  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.main.skip>true</maven.main.skip>
    <maven.test.skip>true</maven.test.skip>
    <jar.skipIfEmpty>true</jar.skipIfEmpty>
    <maven.install.skip>true</maven.install.skip>
    <maven.deploy.skip>true</maven.deploy.skip>
  </properties>

</project>
```


### `SonarQube`质量扫描、`JaCoCo`测试覆盖率等优先使用无侵入的方式，不要写到`pom.xml`

只需在`setting.xml`中配置插件前缀
```xml
<settings>
  <pluginGroups>
    <pluginGroup>org.jacoco</pluginGroup>
    <pluginGroup>org.codehaus.mojo</pluginGroup>
    <pluginGroup>org.sonarsource.scanner.maven</pluginGroup>
  </pluginGroups>
  <profiles>
    <profile>
      <id>sonar</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <properties>
        <!-- Optional URL to server. Default value is http://localhost:9000 -->
        <sonar.host.url>
          http://myserver:9000
        </sonar.host.url>
      </properties>
    </profile>
  </profiles>
</settings>
```
即可直接命令行使用插件
```shell
mvn jacoco:prepare-agent test sonar:sonar findbugs:findbugs pmd:pmd pmd:cpd checkstyle:checkstyle \
  -Dsonar.projectKey=项目标识 \
  -Dsonar.host.url=你的Sonar服务器url \
  -Dsonar.login=令牌 \
  -s /usr/share/maven/conf/settings-自定义后缀.xml
```

在 Jenkins 中可以安装 Warnings Next Generation Plugin 插件，\
使用 Record compiler warnings and static analysis results \
显示各种报告如： java, findbugs, pmd, cpd, checkstyle

其中 Maven 官方的两个插件的使用可以参考：:\
https://maven.apache.org/plugins/maven-pmd-plugin/ \
http://maven.apache.org/plugins/maven-checkstyle-plugin/

SonarQube 的使用可以参考：\
https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-maven/


### 不上传中央仓库的包用命令行代替 distributionManagement

```shell script
mvn deploy -DaltDeploymentRepository=deploymentRepo::default::发布URL
```

使用脚本配置发布 URL，而且 URL 应使用变量：
- Jenkins：系统管理 -> 系统配置 -> 全局属性 -> 环境变量
- Jenkins：系统管理 -> 节点管理 -> 配置从节点 -> 节点属性 -> 环境变量
- GitLab CI：群组设置 -> CI/CD -> 变量


下面这种方式建议在发布中央仓库时才使用，避免仓库迁移等情况需要修改多个 pom.xml

发布中央仓库配置：
```xml
  <!-- 发布管理 -->
  <distributionManagement>
    <repository>
      <id>deploymentRepo</id>
      <name>Nexus Release Repository</name>
      <url>https://oss.sonatype.org/service/local/staging/deploy/maven2</url>
    </repository>
    <snapshotRepository>
      <id>deploymentRepo</id>
      <name>Nexus Snapshot Repository</name>
      <url>https://oss.sonatype.org/content/repositories/snapshots</url>
    </snapshotRepository>
  </distributionManagement>
```

若要在 pom.xml 中设置私服：
```xml
  <!-- 发布管理 -->
  <distributionManagement>
    <repository>
      <id>deploymentRepo</id>
      <url>http://私服地址端口/repository/company_or_app_name_Release/</url>
    </repository>
    <snapshotRepository>
      <id>deploymentRepo</id>
      <url>http://私服地址端口/repository/company_or_app_name_Snapshot/</url>
    </snapshotRepository>
  </distributionManagement>
```

deploymentRepo 是 Maven 配置文件示例的 server id，不要修改，便于统一设置上传密码

setting.xml：
```xml
  <servers>
    <server>
      <id>deploymentRepo</id>
      <username>admin</username>
      <password>admin</password>
    </server>
  </servers>
```