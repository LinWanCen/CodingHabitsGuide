# Maven profile 分环境打包


### 使用`profile`配合`resource`的`filter`对不同环境做不同配置，大多数配置应在配置平台

```xml
<project>
  <properties>
    <envSuffix>dev</envSuffix>
  </properties>

  <build>
    <!-- maven.resources.overwrite 没设置 true 时不会覆盖，即前面的优先 -->
    <resources>
      <resource>
        <directory>${basedir}/src/main/env/${envSuffix}</directory>
      </resource>
      <resource>
        <directory>${basedir}/src/main/resources</directory>
      </resource>
    </resources>
  </build>

  <profiles>

    <!-- 集成测试环境打包 mvn package -P sit -->
    <profile>
      <id>sit</id>
      <properties>
        <envSuffix>sit</envSuffix>
      </properties>
    </profile>

    <!-- 生产环境打包 mvn package -P prd -->
    <profile>
      <id>prd</id>
      <properties>
        <envSuffix>prd</envSuffix>
      </properties>
    </profile>
  </profiles>
</project>
```