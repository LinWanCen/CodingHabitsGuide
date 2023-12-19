# Docker Windows 版

### 安装云缓存的旧版，避免新版各种启动失败
https://mirrors.aliyun.com/docker-toolbox/windows/docker-for-windows/stable

```json
{
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  },
  "experimental": false,
  "features": {
    "buildkit": true
  },
  "registry-mirrors": [
    "http://hub-mirror.c.163.com",
    "https://docker.mirrors.ustc.edu.cn",
    "https://registry.docker-cn.com",
    "https://6kx4zyno.mirror.aliyuncs.com"
  ]
}
```
