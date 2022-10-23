# Git

### 创建分支时打标签标记分支初始代码

方便列代码清单
```sh
git tag 分支名_init
git push origin 分支名_init
git diff tag1 tag2  --name-only > diff.txt
# 中文乱码解决 先改下配置
git config --global core.quotepath false
```


### 使用`.gitignore`文件忽略编译后的文件和本地运行时产生的日志等

IDEA 提示”部分忽略的目录未从索引和搜索中排除“时，\
点击查看目录，排除掉以免搜索到不需要的日志，\
并减少建立索引的时间，**提升性能**

从svn迁移过来的一般在`.gitignore`文件最上面会添加忽略
```gitignore
.svn
```

Git Maven 项目忽略配置参考：[.gitignore](../../.gitignore)

官方文档：
https://mirrors.edge.kernel.org/pub/software/scm/git/docs/gitignore.html


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