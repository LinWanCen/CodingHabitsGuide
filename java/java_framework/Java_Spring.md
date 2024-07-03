# Java Spring 框架使用

### 使用类前缀注解和嵌套字段注解配置变量而不是`@Value`

- 省得编写`xxx-spring-configuration-metadata.json`解释变量
- IDEA 能直接导航到代码
- 可以使用 JSR303 数据校验，如`@NotNull`, `@Length(min = 11)`等
- 可以使用松散绑定语法，即驼峰, 横线, 下划线, 大写都支持
- `@Value` 用于`SpEL`，如`#{2*5}`, `#{2e5}`, `#{'str'}`, `#{true}`, `#{10 gt 0}`, \
  `and,or,not,&&,||`, `?true:false`, `Nullable?:Elvis`, `Nullable?.field|method`, \
  `new/instance of`, `#{T(java.lang.Math).PI}`, `#{user.mobile matches '\d{11}'}`

```java
@ConfigurationProperties(prefix = "server", ignoreUnknownFields = true)
public class ServerProperties {
    private Integer port;
    @NestedConfigurationProperty
    private final ErrorProperties error = new ErrorProperties();
}
```
```
@EnableConfigurationProperties(ServerProperties.class)
```
```
@Value("${server.port}")
private Integer port;
```

# 参数用到自己的 IP 时使用 Spring 变量

${spring.cloud.client.ip-address}:${server.port}