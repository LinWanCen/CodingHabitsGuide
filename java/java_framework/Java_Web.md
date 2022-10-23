# Java Web

### 响应头须指明`Content-Type`

比如微信的接口返回的类型是`text/plain`，会导致 Feign 没有采用 JSON 解析器解析

在 IE、Postman 等软件也不能自动按 JSON 美化，而且 IE 调试里会乱码

Spring MVC 中可以统一设置：
[AddResponseHeaderFilter.java](springboot/config/AddResponseHeaderFilter.java)

或者在单个服务中
```
@RequestMapping(produces = "application/json;charset=UTF-8")
```

### 时间应返回时间戳数字或多浏览器兼容性的字符串

根据阿里规范，不应使用 java.sql 的 Timestamp Date Time

Spring 默认的 `yyyy-MM-dd'T'HH:mm:ss.SSSZ` IE 不兼容

```yml
spring:
  jackson:
    time-zone: GMT+8
    # Chrome 和 IE 9 以上 new Date() 兼容的可视格式
    date-format: yyyy-MM-dd'T'HH:mm:ss.SSS
```


