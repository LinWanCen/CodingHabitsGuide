## Java 包

### 使用`package-info.java`配合文档注释说明包的作用

### 按功能划分包而不是按层划分包

https://phauer.com/2020/package-by-feature/


### 不同模块中的包路径应相同，模块只是隔离依赖关系

在 IDEA 中可以切换为包视图，在这个视图下相关功能的类应在一起，体现高内聚。

不同的模块是为了隔离依赖，比如 DDD 中 proxy 模块依赖了外部 api 和内部 api 提供服务，
其他模块不能 import 外部 api 的内容，就不会被外部 api 污染，体现低耦合。