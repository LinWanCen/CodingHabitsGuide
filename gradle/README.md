# Gradle

[官方文档目录（用于移动端查看）](Gradle_office_doc_catalog.md)

官方文档最佳实践：  
https://docs.gradle.org/current/userguide/authoring_maintainable_build_scripts.html

### 使用 Kotlin DSL

- IntelliJ IDEA 用户在编辑它们时应考虑使用 Kotlin DSL 构建脚本以获得卓越的 IDE 支持
- 虽然首次使用时比 Groovy DSL 慢

详见官方文档：
- https://docs.gradle.org/current/userguide/getting_started.html#command_line_vs_ides
- https://docs.gradle.org/current/userguide/kotlin_dsl.html#kotdsl:limitations

### 选择 多项目构建 或 复合构建

| 中文名    | 多项目构建          | 复合构建         |
| ---       | ------------------- | ---------------- |
| 英文名    | multi-project build | composite builds |
| setting   | include()           | includeBuild()   |
| 设置脚本  | 单个                | 多个             |
| 官方说明  | 统一构建            | 可单个构建       |
| 类比Maven | 父项目              | 聚合             |

详见官方文档：
- https://docs.gradle.org/current/userguide/authoring_maintainable_build_scripts.html#sec:avoiding_use_of_gradlebuild