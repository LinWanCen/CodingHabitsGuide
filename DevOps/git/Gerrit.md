# Gerrit

### 使用 Gerrit 避免每次都要拉取代码才能提交

### 点击右上角 ABANDON 废弃不要的提交避免堆积在 OPEN 中



## 审核

### 审核时若前一个 Gerrit 提交不通过，可以点右上角 REBASE 解除关联

### 审核时可以点击文件清单右上角 EXPAND ALL 滚动查看修改



## 管理

### Submit type 应为 Rebase if necessary

否则每个提交都会有个 Merge 提交，历史线条非常乱


### 禁止开发提交 Merge

开发失误复位到高版本的提交，合并到低版本分支，后面有其他提交时难以恢复

- Reference: refs/for/refs/heads/*
  - Push Merge Commit
    - DENY: MY_REPO/master
    - DENY: Anonymous Users
    - ALLOW: user/Devops


