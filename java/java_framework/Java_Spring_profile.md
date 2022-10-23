# Java Spring 分环境启动配置

### 环境配置使用 active，分类配置使用 include，便于环境变量覆盖

```yml
spring:
  # 在启动用户目录的 .bashrc 中添加类似 export spring_profiles_active=sit
  profiles:
    active: dev
    include:
      - db
      - security
```

### 使用`@Profile`在不同环境启用不同实现或挡板

```
@Profile({"dev", "sit"})
```
