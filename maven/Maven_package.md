# Maven package 打包


### 脚本放在 scripts 目录，可以使用 resources 来替换参数拷贝到指定目录

不包括 SQL 等可以独立拉取执行的脚本

按 Maven 规范放入 `${basedir}/src/main/scripts`(`${project.build.scriptSourceDirectory}`)

官方标准目录结构：http://maven.apache.org/guides/introduction/introduction-to-the-standard-directory-layout.html

```xml
<project>
  <build>
    <!-- maven.resources.overwrite 没设置 true 时不会覆盖，即前面的优先 -->
    <resources>
      <!-- 分环境打包 -->
      <resource>
        <directory>${basedir}/src/main/env/${envSuffix}</directory>
      </resource>
      <!-- 替换脚本中的参数 -->
      <resource>
        <directory>${project.build.scriptSourceDirectory}</directory>
        <filtering>true</filtering>
        <targetPath>${project.build.directory}/zip</targetPath>
      </resource>
      <!-- 保留以免少了这里的文件 -->
      <resource>
        <directory>${basedir}/src/main/resources</directory>
      </resource>
    </resources>
  </build>
</project>
```


### 设置启动类和类路径

```xml
<project>
 <build>
   <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-jar-plugin</artifactId>
        <version>3.2.0</version>
        <configuration>
          <archive>
            <manifest>
              <addClasspath>true</addClasspath>
              <!-- 类路径前缀，dependency 插件自己写入 -->
              <classpathPrefix>lib/</classpathPrefix>
              <!-- 设置启动类 -->
              <mainClass>包路径.启动类</mainClass>
            </manifest>
            <manifestEntries>
              <!-- 类路径，若直接引用本地包时可以换行用 lib/xxx.jar -->
              <Class-Path>./</Class-Path>
            </manifestEntries>
          </archive>
          <!-- 打包不带配置文件 -->
          <excludes>
            <exclude>application.yml</exclude>
          </excludes>
        </configuration>
      </plugin>
   </plugins>
 </build>
</project>
```


### 依赖应该放到 lib 目录，而不是打进一个 jar，以便不升级依赖时减少包大小

```xml
<project>
  <build>
    <plugins>
      <!-- 拷贝 dependencies 的依赖到 lib 目录 -->
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-dependency-plugin</artifactId>
        <version>3.1.2</version>
        <executions>
          <execution>
            <id>copy-dependencies</id>
            <phase>prepare-package</phase>
            <goals>
              <goal>copy-dependencies</goal>
            </goals>
            <configuration>
              <outputDirectory>${project.build.directory}/lib</outputDirectory>
              <overWriteReleases>false</overWriteReleases>
              <overWriteSnapshots>false</overWriteSnapshots>
              <overWriteIfNewer>true</overWriteIfNewer>
              <includeScope>runtime</includeScope>
            </configuration>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
</project>
```


### 使用 antrun 插件来打包 zip，比 assembly 插件更加灵活易学

若`resources`也需要用参数，可以在`resource`配置中多写一次，并配置`filtering`，再拷贝一份到`zip`目录

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

          <!-- 编译前清空 zip 目录，避免删除文件不生效 -->
          <execution>
            <id>zip</id>
            <goals>
              <goal>validate</goal>
            </goals>
            <configuration>
              <!-- http://ant.apache.org/manual/Tasks/ -->
              <target>
                <!-- delete dir 前必须有 mkdir 避免报错 -->
                <mkdir dir="${project.build.directory}/zip"/>
                <delete includeemptydirs="true">
                  <fileset dir="${project.build.directory}/zip/"/>
                </delete>
              </target>
            </configuration>
          </execution>

          <!-- 拷贝外置配置文件和并压缩成 zip，使用：antrun:run@zip -->
          <execution>
            <id>zip</id>
            <goals>
              <goal>run</goal>
            </goals>
            <configuration>
              <!-- http://ant.apache.org/manual/Tasks/ -->
              <target>
                <copy todir="${project.build.directory}/zip" overwrite="true">
                  <fileset dir="${basedir}/src/main/resources"/>
                </copy>
                <copy todir="${project.build.directory}/zip" overwrite="true">
                  <fileset dir="${basedir}/src/main/env/${envSuffix}"/>
                </copy>
                <zip destfile="${project.build.directory}/${project.artifactId}.zip">
                  <fileset dir="${project.basedir}/../" includes="README.md"/>
                  <fileset dir="${project.build.directory}/zip">
                    <include name="**/*.*"/>
                  </fileset>
                </zip>
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