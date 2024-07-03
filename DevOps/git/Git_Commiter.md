# Git 提交

## 拉取

### 拉取使用衍合 Rebase 避免提交多出一个合并分支凌乱

建议使用 Gerrit 避免新手覆盖别人的代码，可以不用拉最新代码直接推送变更

相关规范详见：[Git_Commiter.md](Git_Commiter.md)


### 禁止复位到其他分支


## 提交操作

### 修改大小写时分成删除和添加两次提交

先剪切走提交一次再移回来提交一次，否则其他人拉代码的人可能会报错或者没变化
```
# 设置不忽略大小写
git config core.ignorecase false
```


### 提交时注意作者和邮箱是否正确，避免不统一

https://git-scm.com/book/zh/v2/Git-工具-重写历史


## 提交信息

### 提交信息应带有分支名方便查看

### 提交信息格式 `类型(范围)：总结 Fixed #问题号` 方便看某个对象的相关修改

- Fixed 兼容 GitHub 和 GitLab
- 约定式提交 https://www.conventionalcommits.org/zh-hans/v1.0.0/
  - 类型：fix feat refactor perf test docs style ci build
  - [VS Code 约定式提交插件](https://marketplace.visualstudio.com/items?itemName=vivaxy.vscode-conventional-commits)
  - [IDEA 约定式提交插件](https://plugins.jetbrains.com/plugin/13389-conventional-commit)
    - 建议国内放个中文提示配置文件 [conventionalcommit.json](conventionalcommit.json)

### 提交类型中禁止使用 chore (杂项)
- 约定式提交起源于 Angular 提交规范 https://github.com/angular/angular/blob/main/CONTRIBUTING.md
- Angular 已经删除了 chore，避免 chore 泛滥
- chore 的定义和 ci build test docs 重叠
- chore 这个单词国内不太多人认识

## 其他

### 使用`.gitkeep`空文件在`Git`中保留空文件夹
