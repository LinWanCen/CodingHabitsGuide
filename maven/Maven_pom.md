# Maven pom 基本配置

### 中文团队下项目需添加名称标签 `<name>${project.artifactId} | 简称1 | 简称2</name>`

简称可以是中文或英文，这样在`Maven`日志、`SonarQube`报告、`IDEA`侧边栏等显示都更为友好

pom 项目信息官方文档：https://maven.apache.org/pom.html#more-project-information

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

  <packaging>pom</packaging>

  <name>${project.artifactId} | 日志演示聚合项目</name>
  <description>用于一起编译，不要以此为父项目</description>

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

## 非 Maven 项目升级到 Maven 项目时一般不修改目录结构，依赖不改成仓库下载

强行修改目录结构会影响原有的开发模式，开发需要时间适应

为 DevOps 升级 Maven 应优先使用不修改目录的低侵入形式无缝升级，

只添加 pom.xml 等文件，并做分环境打包等

### 推荐按标准顺序放置标签

来自 Sonar 的提示
```xml
<project>
  <modelVersion/>
  <parent/>
  <groupId/>
  <artifactId/>
  <version/>
  <packaging/>
  <name/>
  <description/>
  <url/>
  <inceptionYear/>
  <organization/>
  <licenses/>
  <developers/>
  <contributors/>
  <mailingLists/>
  <prerequisites/>
  <modules/>
  <scm/>
  <issueManagement/>
  <ciManagement/>
  <distributionManagement/>
  <properties/>
  <dependencyManagement/>
  <dependencies/>
  <repositories/>
  <pluginRepositories/>
  <build/>
  <reporting/>
  <profiles/>
</project>
```