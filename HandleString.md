# 字符串操作

- [字符串操作](#%e5%ad%97%e7%ac%a6%e4%b8%b2%e6%93%8d%e4%bd%9c)
  - [1. 取字符串长度](#1-%e5%8f%96%e5%ad%97%e7%ac%a6%e4%b8%b2%e9%95%bf%e5%ba%a6)
  - [2. 子字符串](#2-%e5%ad%90%e5%ad%97%e7%ac%a6%e4%b8%b2)
  - [3. 搜索和替换](#3-%e6%90%9c%e7%b4%a2%e5%92%8c%e6%9b%bf%e6%8d%a2)
    - [头部模式匹配](#%e5%a4%b4%e9%83%a8%e6%a8%a1%e5%bc%8f%e5%8c%b9%e9%85%8d)
    - [尾部模式匹配](#%e5%b0%be%e9%83%a8%e6%a8%a1%e5%bc%8f%e5%8c%b9%e9%85%8d)
    - [任意位置模式匹配](#%e4%bb%bb%e6%84%8f%e4%bd%8d%e7%bd%ae%e6%a8%a1%e5%bc%8f%e5%8c%b9%e9%85%8d)
  - [4. 改变大小写](#4-%e6%94%b9%e5%8f%98%e5%a4%a7%e5%b0%8f%e5%86%99)

## 1. 取字符串长度

语法 `${#varname}`

```
# example
echo ${#PATH}
```

## 2. 子字符串

语法 `${varname:offset:length}`

- 只能操作变量，不能直接操作值
- offset 可以为负值，计数将从后计算。注意减号前面必须加个空格，用于区分 `${variable:-word}` 变量的默认值语法
- 子字符串不会修改变量的值，而是创建一个新的字符串

```
# example
count=frogfootman
# 从下标 4 开始取 4 个长度
echo ${count:4:4}

# offset 可以为负值
echo ${count: -4:4}
```

## 3. 搜索和替换

Bash 提供字符串搜索和替换的办法

- 字符串头部模式匹配
- 字符串尾部模式匹配
- 任意位置模式匹配

### 头部模式匹配

检查字符串开头，是否匹配给定的模式（pattern）。
匹配成功旧删除匹配的部分，返回剩下的部分。
pattern 支持使用`*`、`?`、`[]` 等通配符扩展。

语法
- 删除最短匹配（非贪婪） `${variable#pattern}`
- 删除最长匹配（贪婪） `${variable##pattern}`
- 替换匹配内容 `${variable/#pattern/string}`

```
# 非贪婪
myPath=/home/cam/book/long.file.name
echo ${myPath#/*/}
# 输出 cam/book/long.file.name

# 贪婪
echo ${myPath##/*/}
# 输出 long.file.name

# 替换
var1=abc
echo ${var1/#a/hello}
# 输出 hellobc
```

### 尾部模式匹配

检查字符串结尾，匹配给定模式，匹配成功旧删除，返回剩下部分。

语法
- 删除最短匹配（非贪婪）`${variable%pattern}`
- 删除最长匹配（贪婪）`${variable%%pattern}`
- 替代匹配内容 `${variable/%pattern/string}`

```
# 非贪婪
myPath=/home/cam/book/long.file.name
echo ${myPath%.*}
# 输出 /home/cam/book/long.file

# 贪婪
echo ${myPath%%.*}
# 输出 /home/cam/book/long

# 替换
var1=abc
echo ${var1/%c/dd}
# 输出 abdd
```

### 任意位置模式匹配

语法
- 匹配第一个并替换 `${variable/pattern/string}` ，`/string` 部分不写即为删除
- 匹配所有并替换 `${variable//pattern/string}` ，`/string` 部分不写即为删除

```
var1=a/b/a/c/a.jpg
echo ${var1/a}
# 输出 /b/a/c/a.jpg

echo ${var1//a}
# 输出 /b//c/.jpg
```

## 4. 改变大小写

- 转为大写 `${varname^^}`
- 转为小写 `${varname,,}`