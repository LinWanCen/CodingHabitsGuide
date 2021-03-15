# Maven_deploy


### `war`包等用于部署的模块应该配置忽略安装和发布到仓库

通常特别大，而且不会被引用
```xml
  <properties>
    <!-- 避免被安装发布到仓库 -->
    <maven.install.skip>true</maven.install.skip>
    <maven.deploy.skip>true</maven.deploy.skip>
  </properties>
```


### 推送私服用命令行代替 distributionManagement 配置

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

deploymentRepo 是 Maven 配置文件示例的 server id，若没有多个就不要修改，便于统一设置上传密码

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