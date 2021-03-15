# Maven pmd 代码扫描

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