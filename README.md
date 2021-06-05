# DevTestOpsGuide
for DevTestOps and DevSecOps

本指南是对 [谷歌风格指南][styleguide] 和 [阿里巴巴Java开发手册][p3c] 等指南的补充，
请在阅读本指南的同时请阅读这些指南。

因为域名污染进不了 xxx.github.io 的同学请修改 DNS 后刷新缓存，参考： 
https://www.zhihu.com/question/411565676

[styleguide]:https://github.com/google/styleguide
[p3c]:https://github.com/alibaba/p3c

## 指南内容的撰写

您可以新增一些条目，但修改条目时请在 issues 等平台充分讨论后再修改，不要在修改记录中争执。

这里的条目需要同时写明这么做的缘由，条目的来源可以是遇到的问题(bug)或者不便的地方。

新增条目前请先搜索 [谷歌风格指南][styleguide] 和 [阿里巴巴Java开发手册][p3c] 等资料是否已经提到。

编写条目前请务必阅读 [谷歌风格指南][styleguide] 中的 [文档风格指南][docguide]。

[docguide]:https://github.com/google/styleguide/blob/gh-pages/docguide/style.md


## 具体内容


### Java

[Java 编码注释运维](java/README.md)

[日志指南](log/README.md)

[Java 测试](java_test/README.md)

[Maven 指引](maven/README.md)


### DB

[数据库 DB](db/README.md)


### 代码管理

[分支管理 Branch](DevOps/Branch.md)

[软件配置管理 SCM（版本控制&变更控制）](DevOps/SCM.md)

[代码审核 CodeReview](DevOps/CodeReview.md)

语义化版本 2.0.0：https://semver.org/lang/zh-CN/

Git Maven 项目忽略配置参考：[.gitignore](.gitignore)

https://mirrors.edge.kernel.org/pub/software/scm/git/docs/gitignore.html


### JS
JS(JavaScript) / ES5(ECMAScript 5.0) / ES6

ES lint：http://eslint.cn/docs/rules/

Vue 风格指南：https://cn.vuejs.org/v2/style-guide/


### 设计

设计上的基本常识 (dubbo)：http://dubbo.apache.org/zh-cn/docs/dev/principals/general-knowledge.html

使用 PlantUML 编写时序图等理清关系：https://plantuml.com/zh/sequence-diagram

