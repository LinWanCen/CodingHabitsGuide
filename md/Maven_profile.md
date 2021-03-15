# Maven_profile


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