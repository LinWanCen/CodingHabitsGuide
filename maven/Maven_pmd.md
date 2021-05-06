# Maven pmd 代码扫描

### `SonarQube`质量扫描、`JaCoCo`测试覆盖率等优先使用无侵入的方式，不要写到`pom.xml`

```shell
mvn -V -U org.jacoco:jacoco-maven-plugin:prepare-agent verify org.jacoco:jacoco-maven-plugin:report org.sonarsource.scanner.maven:sonar-maven-plugin:sonar \
  -Dsonar.projectName="${projectName}" \
  -Dsonar.projectKey=${projectKey} \
  -Dsonar.host.url=${sonarURL} \
  -Dsonar.login=${sonarLogin} \
  -s /usr/share/maven/conf/settings-自定义后缀.xml
mvn org.codehaus.mojo:findbugs-maven-plugin:findbugs
mvn pmd:pmd
mvn pmd:cpd
mvn checkstyle:checkstyle
```
后面几句省略了其他参数，如果编译或单元测试困难可以加下面的参数
```shell
  -Dmaven.compiler.failOnError=false \
  -Dmaven.test.failure.ignore=true \
```

### 非 Maven 官方插件使用全名而不是配置插件群组
在`setting.xml`中配置插件前缀可以缩短命令长度，方便手动使用命令，但是降低了迁移的便捷性
```xml
<settings>
  <pluginGroups>
    <pluginGroup>org.jacoco</pluginGroup>
    <pluginGroup>org.codehaus.mojo</pluginGroup>
    <pluginGroup>org.sonarsource.scanner.maven</pluginGroup>
  </pluginGroups>
</settings>
```
这里省略了其他参数
```shell
mvn -V -U jacoco:prepare-agent verify jacoco:report sonar:sonar
mvn findbugs:findbugs
```

在 Jenkins 中可以安装 Warnings Next Generation Plugin 插件，\
使用 Record compiler warnings and static analysis results \
显示各种报告如： java, findbugs, pmd, cpd, checkstyle

其中 Maven 官方的两个插件的使用可以参考：:\
https://maven.apache.org/plugins/maven-pmd-plugin/ \
http://maven.apache.org/plugins/maven-checkstyle-plugin/

SonarQube 的使用可以参考：\
https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-maven/


### 提交较为频繁的项目不要设置触发器，耗时较长的在非上班时间运行以减少虚拟机资源占用

```
H H(0-7),H(12-13),18 * * *
```