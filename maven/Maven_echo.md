# Maven echo 输出信息

### 可以用 antrun 在生命周期的各个位置中打印一些信息

生命周期官方文档：http://maven.apache.org/ref/3.6.3/maven-core/lifecycles.html


### 在编译前用打印一些变量，便于跟踪是否传参错误

以下是`execution`集合，每个前面都应有注释
```xml
<project>
  ...
  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-antrun-plugin</artifactId>
        <version>3.0.0</version>
        <executions>
          <!-- 环境提示 -->
          <execution>
            <id>echo</id>
            <phase>validate</phase>
            <goals>
              <goal>run</goal>
            </goals>
            <configuration>
              <!-- http://ant.apache.org/manual/Tasks/ -->
              <target>
                <echo level="info">path.separator: ${path.separator}</echo>
                <echo level="info">envSuffix: ${envSuffix}</echo>
              </target>
            </configuration>
          </execution>

        </executions>
      </plugin>
    </plugins>
  </build>
  ...
</project>
```