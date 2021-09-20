# Jenkins_Sonar

Maven项目名：GitLab路径"/"改"_"_sonar 
项目名：GitLab路径"/"改"_"_sonarScanner 

### 复制节点教程
1. 在 系统配置 > 管理节点 > 新建节点 > 复制现有节点，修改：名称、描述、主机


### 复制项目教程（放到 Jenkins 界面的描述）
1. 复制相同类型的项目名（devops_QA_log-demo-pom_sonar），点击左侧新建Item，在最下面复制处粘贴 
2. 修改：定制项目的运行节点、Repository URL、执行 shell 的 projectName、projectKey（不要重复）
3. 复制 GitLab webhook URL 和高级下的 Secret token 到 GitLab 项目 > 设置 > Webhooks 中，点击下面的 Add webhook 保存。
4. 保存 Jenkins 配置后在 GitLab Webhooks 中点击测试 
5. 在 Jenkins 页面等待执行完成后查看报告，SonarQube 报告在 Sonar 页面


### 节点软件安装
```shell
chmod 777 /etc/yum.repos.d
yum install git

chmod 777 /opt
tar zxvf /opt/jdk-8u201-linux-x64.tar.gz
tar zxvf /opt/apache-maven-3.6.3
unzip /opt/sonar-scanner-4.3.0.2102-linux.zip

chmod 777 /etc/profile.d
```


### 新建节点教程
1. 在 系统配置 > 管理节点 > 新建节点 > 固定节点
2. 远程工作目录：/var/lib/jenkins
3. 用法：只允许运行绑定到这台机器的Job
4. 启动方式：Launch agents via SSH
5. Host Key Verification Strategy：Non verifying Verification Strategy
6. 右下角高级：
7. JVM 选项：-Dfile.encoding=UTF-8


### 新建项目教程