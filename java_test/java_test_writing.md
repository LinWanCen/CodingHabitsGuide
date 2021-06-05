# java_test_writing

### 较长的测试使用 GWT 格式定义

GIVEN, WHEN, THEN

设参、调用、断言


### 注意断言参数顺序，期望在中间
```
JUnit  assertEquals(可选描述, 期望, 实际)
TestNG assertEquals(实际, 期望, 可选描述)
```

### 使用 TestNG

- JUnit 的 before 每个类前都会运行一次
- TestNG 支持依赖


### 所有测试类都应最终继承本项目的某个类

本项目的这个类再继承公共模块，方便改造

- JUnit 要实现在所有测试前执行必须用继承
- TestNG 虽然可以不用继承，使用`@BeforeSuite`在所有类前只执行一次，但是单个运行时就不会生效

| TestNG         | JUnit 5     | JUnit 4      | JUnit method | spock       |
| -------------- | ----------- | ------------ | ------------ |------------ |
| @BeforeSuite   |             |              |              |             |
| @BeforeTest    |             |              |              |             |
| @BeforeGroups  |             |              |              |             |
| @BeforeClass   | @BeforeAll  | @BeforeClass | is static    | setupSpec() |
| @BeforeMethod  | @BeforeEach | @Before      | no static    | setup()     |
| @Test(priority | @Order(1)   |              |              |             |
| @Ignore        | @Disabled   | @Ignore      |              |             |
| @Test(groups   | @Tag        | @Categories  |              |             |


### 注意 JUnit 方法是否静态的要求

### 注意没设置时 TestNG 会忽略带返回值的测试方法

### 依赖环境的测试使用条件标签便于过滤

#### TestNG 过滤

TestNG 组`@Test(groups = { "db", "slow" })`:
https://testng.org/doc/documentation-main.html#test-groups

TestNG 命令执行过滤组`-groups`, `-excludegroups db,slow`：
https://testng.org/doc/documentation-main.html#running-testng


#### JUnit 5 过滤

JUnit 5 条件执行`@EnabledIf("cn.demo.test.DbOnline")`：
https://JUnit.org/JUnit5/docs/current/user-guide/#writing-tests-conditional-execution

JUnit 5 标签`@Tag("db")`, `@Tag("slow")`:
https://JUnit.org/JUnit5/docs/current/user-guide/#writing-tests-tagging-and-filtering

JUnit 5 命令执行过滤标签`-t`, `-T=db -T=slow`：
https://JUnit.org/JUnit5/docs/current/user-guide/#running-tests-console-launcher-options

JUnit 5 Maven执行过滤标签：
https://JUnit.org/JUnit5/docs/current/user-guide/#running-tests-build-maven-filter-tags
```xml
      <plugin>
          <artifactId>maven-surefire-plugin</artifactId>
          <version>2.22.2</version>
          <configuration>
              <groups>acceptance | !feature-a</groups>
              <excludedGroups>integration, regression</excludedGroups>
          </configuration>
      </plugin>
```


### 必要时做多线程测试

#### TestNG 多线程
```
@Test(threadPoolSize = 3, invocationCount = 10,  timeOut = 10000)
```