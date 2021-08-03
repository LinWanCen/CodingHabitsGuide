## 持续部署 CD（发布）

### 部署时使用全路径以便在进程中看到

### 版本投产减少手工步骤，原则上都应该自动化投产，手工步骤必须有检查机制

### 测试环境被依赖方做灰度部署，避免影响依赖方开发进度

### 传输的包需校验 MD5 值检查是否损坏或被篡改

```shell
# Windows
certutil -hashfile 文件路径 md5
# Linux
md5sun 文件路径
```

### 应检查环境配置是否有错

```shell
find . -regex ".*\.\(properties\|yml\|xml\)" | xargs grep "测试环境地址"
```