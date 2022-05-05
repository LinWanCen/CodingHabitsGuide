# 正则表达式高级
——《精通正则表达式》
+Java/Go/Python官方文档
+多年经验
+实验结果
知识整理

[正则表达式优化](RegExpOpti.md)

[TOC]

第3章 正则表达式的特性和流派概览

## 常用的元字符和特性  102

基本语法
https://www.runoob.com/regexp/regexp-metachar.html

### 量词

- `{n}` `{n,}` `{n,m}`
- `*`同`{0,}`
- `+`同`{1,}`
- `?`同`{0,1}`
- 量词默认匹配优先(贪婪，越多越好)
- **后面加`?`则忽略优先(非贪婪，越少越好)**

- 后面加`+`则占有优先(类似固化分组, golang不支持)，
匹配了就不会还回去，例如
用`.*+c`匹配`abc`，
`.*`会匹配优先地匹配到`abc`三个字符，
如果没有`+`时发现匹配失败就会回溯到`.*`匹配两个的情况，这时匹配成功；
而有`+`就占有不还回去了，匹配失败。

### 分组与捕获

```Java
"abc".replaceAll("a(.*)c", "s$1"); // sb
"b2b".replaceAll("(.*)2\\1", "s$1"); // sb

"b2b".replaceAll("(?<a>.*)2\\k<a>", "s${a}"); // sb

Pattern p = Pattern.compile("a(?<a>.*)c");
Matcher m = p.matcher("abc");
while (m.find()) {
    System.out.println(m.group(1)); // b
    System.out.println(m.group("a")); // b
}
```
反向引用组编号n为0代表全部，同`m.group()`

- **分组并捕获`(...)`**
- 正则反向引用(Java Python)`\n`(golang貌似未提供)
- **字符反向引用(Java golang)`$n`**
- 字符反向引用(Python)`\n` `\g<n>`
- 
- 命名捕获(Java)`(?<name>...)`
- 正则反向引用(Java)`\k<name>`
- 字符反向引用(Java golang)`${name}`
- 字符反向引用(golang)`$name`
- 
- 命名捕获(Python golang)`(?P<name>...)`
- 正则反向引用(Python)`(?P=name)`
- 字符反向引用(Python)`\g<name>`
- 
- **多选结构`...|...`**
- **仅分组不捕获`(?:...)`**
- 固化分组(golang不支持)`(?>...)`
- 
- 注释(宽松排列时 golang不支持)`# ...`

Java不支持：
- 条件(Python)`(?(n/name)...|...)`
- 代码条件`(?... ...|...)`
- 嵌入式注释`(?#...)`
- 嵌入式代码`(?{...})`
- 动态表达式`(??{...})`

### 边界

锚点：
- **行始`^`**
- 文始`\A` `\G`
- **行末`$`**
- 文末`\Z` `\z`
- 单词边界`\b`
- 非单词边界`\B`

环视结构(零长度断言，golang不支持)：
- 顺序环视
   - **左边是A:`(?<=A)`**
   - **左边不是A:`(?<!A)`**
- 逆序环视
   - **右边是A:`(?=A)`**
   - **右边不是A:`(?!A)`**
```Java
"abc".replaceAll("(?<=a)b(?=c)", ""); // ac
```
**查找时用捕获比环视更容易阅读**

### 注释与模式

通用常用
- `(?i)`不区分大小写`CASE_INSENSITIVE`(Java 轻微影响性能)
- `(?m)`多行模式(`^`和`$`匹配整个字符串的头尾)`MULTILINE`
- `(?s)`点号通配模式(.匹配任意字符)`DOTALL`

Java
- `(?idmsuxU-idmsuxU)`
- `(?idmsux-idmsux:X)`
- `(?u)`Unicode不区分大小写`UNICODE_CASE`(影响性能)
- `(?x)`宽松排列和注释(忽略空白和#后的内容)`COMMENTS`
- `(?d)`Unix行模式(只有`\n`)`UNIX_LINES`
- Unicode按规则等价`CANON_EQ`(影响性能)
- `\Q...\E`不使用元字符和转义序列`LITERAL`(1.5+)
- `(?U)`启用预定义和POSIX字符类UNICODE_CHARACTER_CLASS(1.7+，影响性能)

Python
- `(?aiLmsux-imsx:…)`
- `(?a)`仅ASCII
- `(?L)`语言依赖

其他
- `(?o)`编译一次(提升性能，Perl)
- `(?U)`忽略优先模式交换`x*`和`x*?`...的含义(golang)

也可以这样用：`(?-i)` `(?i:...)` `(?-i:...)`

```Java
Pattern p = Pattern.compile("a(?i)b(?-i)c(?i:d)");
Matcher m = p.matcher("aBcD");

Pattern p = Pattern.compile("a", Pattern.CASE_INSENSITIVE);
```

### 字符组

- `.` 换行符外任意字符
- `[...]`字符组(元字符不需转义)
如`[a-z]`匹配小写字母
- `[^...]`不包含

Perl字符族：
- `\d`同`[0-9]`
- `\D`同`[^0-9]`
- `\w`同`[A-Za-z0-9_]`
- `\W`同`[^A-Za-z0-9_]`
- `\s`同`[ \t\n\v\f\r]`
- `\S`同`[^ \t\n\v\f\r]`
- 
- `\C`字节
- `\X`Unicode

ASCII字符族(来自golang):
`[[:alnum:]]`字母数字同`[0-9A-Za-z]`
`[[:alpha:]]`字母同`[A-Za-z]`
`[[:ascii:]]`ASCII同`[\x00-\x7F]`
`[[:blank:]]`空白`[\t ]`
`[[:cntrl:]]`控制`[\x00-\x1F\x7F]`
`[[:digit:]]`数字`[0-9]`
`[[:graph:]]`图形`[!-~] == [A-Za-z0-9!"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]`
`[[:lower:]]`小写`[a-z]`
`[[:print:]]`可打印`[ -~] == [ [:graph:]]`
`[[:punct:]]`标点`[!-/:-@[-`{-~]`
`[[:space:]]`空字符`[\t\n\v\f\r ]`
`[[:upper:]]`大写`[A-Z]`
`[[:word:]]`字符`[0-9A-Za-z_]`
`[[:xdigit:]]`十六进制`[0-9A-Fa-f]`

Unicode组：
- `\p{}`Unicode 区块/属性/分类，如

java汉字
```Java
"Hi,你好!".replaceAll("[^\\p{javaIdeographic}]", ""); // 你好
Character.isIdeographic(int codePoint) // CJKV（中文，日文，韩文和越南文）表意文字
```

https://docs.oracle.com/en/Java/Javase/12/docs/api/Java.base/Java/util/regex/Pattern.html


golang汉字
```golang
package main_test

import (
	"fmt"
	"regexp"
)

func ExampleFindAllString() {
	r := regexp.MustCompile(`[\p{Han}]+`) // 汉字
	split := r.FindAllString("你好，中国！", -1)
	for _, s := range split {
		println(s) // 不计入output
		fmt.Println(s)
	}

	// Output:
	// 你好
	// 中国
}
```

https://studygolang.com/static/pkgdoc/pkg/regexp.htm

https://godoc.org/regexp/syntax

https://godoc.org/regexp


python汉字
```Python
# coding=utf-8
import re
if __name__ == "__main__":
    print(re.findall(r'[\u4e00-\u9fa5]+', '你好，中国！'))
```

https://docs.Python.org/zh-cn/3/library/re.html#contents-of-module-re

### 字符

- `\a`警报同`\x09` `\cI`
- `\b`退格同`\x09` `\cI`
- `\e`退出同`\x09` `\cI`
- 
- `\t`制表同`\x09` `\cI`
- `\n`换行同`\x0a` `\cJ`
- `\v`直表同`\x0b` `\cK`
- `\f`分页同`\x0c` `\cL`
- `\r`回车同`\x0d` `\cM`
- `\*`
- 
- `\07` `\77` `0377`八进制(带0是Java特殊)
- `\xFF` `\uFFFF` 十六进制
- `\x{10FFFF}` 十六进制(golang)
- `\u00A9`Unicode 版权符号
- 
- `\Q...\E`不使用元字符和转义序列
