# 开机启动参考

本参考不算是最佳实践，只是我们生产正在使用，仅作参考

```sh
# su 到 root 用户操作
vim /etc/rc.local
chmod +x /etc/rc.d/rc.local
# 添加启动脚本，注意给下面的脚本添加运行权限 chmod +x
/etc/profile.d/java_env.sh
/home/admin/auto_start_app.sh
# 重启
reboot
# 验证是否正常启动
jps -l
```

auto_start_app.sh
```sh
rm -rf /home/admin/tomcat/bin/tomcat.pid
/home/admin/tomcat/bin/startup.sh
```
