# SQL

### `INSERT`语句建议在工具上编辑好值后使用将所选行导出为`INSERT`语句的方式

在工具中编辑是为了方便在图形界面中观察每条记录的差别，导出的语句方便也避免了繁琐的语法编辑和错漏。


### 复制语句时把需要修改的值位置先清空

先清空需修改的值是为了减少漏改问题，比如值是一串数字，一整排下来可能复制粘贴就漏了一个。


### `SQL`也是代码的一部分，应该提交到另一个 Git 仓库中

有的平台不支持局部拉取代码，全量拉取就很耗时，所以应放在另一个仓库

注意不要把参数的-弄成–，否则 MySQL 会无报错打印一堆帮助信息让人摸不着头脑

```sh
# -v 显示日志 -U 禁止无 where 更新
mysql -v -U -uroot -proot -h $IP -P 3306 < mysql_run.sql
set character set utf8;

# 避免 Oracle 乱码
export NLS_LANG="AMERICAN_AMERICA.AL32UTF8"
sqlplus system/system@$IP:1521/ORCL @oracle_run.sql
```