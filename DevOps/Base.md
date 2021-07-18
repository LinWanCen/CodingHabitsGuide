# 基础设施

给初创 IT 部门的朋友

### 共享盘初建时一定要有一级目录文件夹

否则会跟桌面一样文件丢得乱七八糟
```
【安装包】/JDK/Linux
【部门中心】/信息科技部/应用研发中心
【各项目组】/资金系统/林万程
【视频教程】/资金系统/
【临时可删】
MAVEN_REPO/ticm
```

### 使用域名服务器，必须使用域名

否则后续所有文档、服务配置都充斥着 IP 会很难受

### 设置域名解析超时时间

因为默认 30 秒 5 次会导致两分半钟的等待

```sh
su
vim /etc/resolv.conf
添加
options timeout:1 attempts:2 rotate single-request-reopen
nameserver 域名服务器1的IP
nameserver 域名服务器2的IP
```

### 设置主机名，并用在线文档或系统管理清单

便于一些平台辨认主机是干什么的

```sh
vim /etc/hostname
```

### 采购的网络火墙等系统要有人性化的申请流程

否则后期手工开火墙、开账号等低价值的工作让人心烦意乱


### 搭建 LDAP 服务管理开发平台用户

支持 LDAP 的比较多，推荐 ApacheDS，OpenLDAP 安装比较多问题

https://directory.apache.org/

Gitlab、Jenkins、Jira、Confluence、Graylog

或者用 GitLab 的 OAuth 2.0 作为 Jenkins、Sonar 等系统的单点登录