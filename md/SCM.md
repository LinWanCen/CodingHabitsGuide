# 软件配置管理 SCM（版本控制&变更控制）

## `SVN`与`Git`

### `SVN`迁移`Git`可以保留提交记录，尽量保留提交记录迁移

```shell
git svn clone svn地址 --username=用户名
```

### `Git`可以按目录拉取，可以拆分并保留提交记录

```shell
git config core.sparsecheckout true
echo "subDir/" >> .git/info/sparse-checkout
git pull origin master
```
https://git-scm.com/docs/git-sparse-checkout


### 使用`.gitkeep`空文件在`Git`中保留空文件夹

### 提交时注意作者和邮箱是否正确，避免不统一

https://git-scm.com/book/zh/v2/Git-工具-重写历史


### 把会出现多人同时添加的公共文件拆分成多个

比如每个服务一个配置文件而不是在同个文件中，避免同时添加或不同分支合并出现冲突


### 分工时依据修改添加哪些文件分工，必要时指定清楚

否则两个人都添加或修改了同一处就会出现冲突


### GitLab 项目都放到一个一级群组中，二级群组不要按部门创建

以便在一级群组中设置全局变量

部门可能变化，而路径不应该变化，久而久之路径就不准确了


## 心得

### 版本投产减少手工步骤，原则上都应该自动化投产，手工步骤必须有检查机制

### 测试环境被依赖方做灰度部署，避免影响依赖方开发进度

### 发现问题不只是改正，要对全量代码和历史数据做全面排查

### 不用对人设置权限，把人设置到角色/组，然后给角色/组设置权限

人总是会变动的，一旦变动的话，修改按人设置的权限就很大工作量


## 持续集成 CI（构建）

### 敏捷开发下定时构建自动在 Git 上打 Tag 方便开发拉代码就能看到自己的代码上环境没

- 标签不支持空格和冒号，不能用`yyyy-MM-dd HH:mm:ss`
- 空格换成下划线的话双击时会连带选择
- 如果是比较高的符号会影响视觉分隔效果
- 虽然大写更有美感也符合转悠名词的习惯，\
  但在 Maven 中`resources_PRD`看起来不协调，\
  而且输入时不便，视觉辨识度也较低，所以用小写

所以采用逗号：
```
prd,yyyy-mm-dd,hh.mm.ss
其中：
sit 集成测试
uat 验收测试
ndt 自然日测试
pet 性能测试
sim 仿真/模拟测试
pre 灰度/投演
prd 生产
```

https://git-scm.com/book/zh/v2/Git-基础-打标签
```shell
#git config --global http.sslVerify false
tag_name=prd,$(date +"%Y-%m-%d,%H.%M.%S")
git tag ${tag_name}
git push origin ${tag_name}
```
