# 表设计

### 设计表时字段默认`not null`, 减少判空与空指针异常

可空字段必须明确说明原因，否则都必须非空，在特殊情况下程序疏漏可能插入空值，从而导致一系列问题。

可空字段漏了判空会导致空指针异常，需要频繁判空。

当然，在这条规则下写程序时仍需了解数据库字段，可空/非空 与其他字段不同的需要用文档注释标注，
在`SpringMVC`等可以使用`@Validated`的建议注解`@NotNull`

上面提到的两个注解具体路径为
```java
import org.springframework.validation.annotation.Validated;
import javax.validation.constraints.NotNull;
```


### 大表考虑分区，可以非常简单地提升整个性能


### 开发测试环境的表与字段必须有注释

[DB_COMMENT.md](DB_COMMENT.md)