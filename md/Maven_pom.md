# Maven_pom

### 中文团队下项目需添加名称标签 `<name>${project.artifactId} | 简称1 | 简称2</name>`

简称可以是中文或英文，这样在`Maven`日志、`SonarQube`报告、`IDEA`侧边栏等显示都更为友好

根据官方文档 https://maven.apache.org/pom.html#more-project-information

```xml
  <name>开发们常用的简称</name>
  <description>核心功能和在整个架构中的作用</description>
  <inceptionYear>成立年份</inceptionYear>
  <url>链接</url>
```

`Spring Boot`
```xml
  <artifactId>spring-boot-starter-parent</artifactId>
  <name>Spring Boot Starter Parent</name>
  <description>Parent pom providing dependency and plugin management for applications
		built with Maven</description>
```

### `SonarQube`质量扫描、`JaCoCo`测试覆盖率等优先使用无侵入的方式，不要写到`pom.xml`

只需在`setting.xml`中配置插件前缀
```xml
<settings>
    <pluginGroups>
        <pluginGroup>org.jacoco</pluginGroup>
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
mvn jacoco:prepare-agent test sonar:sonar \
  -Dsonar.projectKey=项目标识 \
  -Dsonar.host.url=你的Sonar服务器url \
  -Dsonar.login=令牌 \
  -s /usr/share/maven/conf/settings-自定义后缀.xml
```


### 使用`profile`配合`resource`的`filter`对不同环境做不同配置，大多数配置应在配置平台


### 不应使用`systemPath`引用本地包

会使与他有关的项目难以编译


### `maven-compiler-plugin`添加`jar`路径时必须添加`${project.basedir}`，否则在`Linux`下可能会找不到包

3.1 前
```
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
3.1 后（最新版看http://maven.apache.org/plugins/maven-compiler-plugin/usage.html）
```
      <plugin>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.8.1</version>
        <configuration>
          <compilerArgs>
            <arg>-verbose</arg>
            <arg>-Xlint:unchecked</arg>
            <arg>-Xlint:deprecation</arg>
            <arg>-extdirs</arg>
            <arg>${project.basedir}/src/main/resources/lib</arg>
          </compilerArgs>
        </configuration>
      </plugin>
```
