# 常用命令记忆

## 压缩解压

- 文件顺序都是 压缩后 压缩前，因为压缩前可以是多个文件
- `zip`/`unzip`
- `tar zcvf 压缩后.tar.gz 文件或目录1 文件2...`
  - z gzip
  - c create 创建
  - x extract 提取
  - v verbose 显示过程
  - f file 指定文件

```sh
sed -in "s/\$"{"key}/$key/g" pom.xml
grep "行标识字符" pom.xml
```

## IP 查机器
```batch
# 助记语：你不替食堂熬汤
nbtstat -A IP
```
、

## 端口查进程
```batch
# 最后一列为 PID
netstat -ano | findstr "端口"
tasklist | finstr "PID"
```

## 文件列表

```sh
# Linux
find -name *.java

# Windows 傻逼 fin(d)str
dir /s/b finstr *.java
```

## 剪切板
```batch
echo|set/p=文本|clip
# 或
set/p="文本"<nul|clip
```