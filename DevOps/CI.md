## 持续集成 CI（构建）

### 设置最后封板时间并严守，以便有足够的时间编译程序包做回归测试

### 编译日志同时保存到文件后用工具解析出错行作者，根据时间倒序发邮件
`2>&1|tee maven.log`

### 任何脚本运行的操作都要搜下是否有乱码的可能

例如 Maven 打包、执行 SQL、日志

### 敏捷开发下定时构建自动在 Git 上打 Tag 方便开发拉代码就能看到自己的代码上环境没

- 标签不支持空格和冒号，不能用`yyyy-MM-dd HH:mm:ss`
- 空格换成下划线的话双击时会连带选择
- 但是是较高的符号会影响视觉分隔效果，所以用下划线
- 英文逗号常用于分割符，所以用英文句号
- 虽然大写更有美感也符合专有名词的习惯，\
  但在输入时不便，视觉辨识度也较低，所以用小写

```
prd_yyyy-mm-dd_hh.mm.ss
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
```sh
export TZ='CST-8'
time_suffix=$(date +"%Y-%m-%d_%H.%M.%S")
git config --global http.sslVerify false
git tag ${tag_prefix}${time_suffix}
git push origin ${tag_prefix}${time_suffix}
```
