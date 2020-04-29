# read 命令

- [read 命令](#read-%e5%91%bd%e4%bb%a4)
  - [1. 用法](#1-%e7%94%a8%e6%b3%95)
  - [2. 参数](#2-%e5%8f%82%e6%95%b0)
    - [2.1 -t](#21--t)
    - [2.2 -p](#22--p)
    - [2.3 -a](#23--a)
    - [2.4 -n](#24--n)
    - [2.5 -e](#25--e)
    - [2.6 其他参数](#26-%e5%85%b6%e4%bb%96%e5%8f%82%e6%95%b0)
  - [3. IFS 变量](#3-ifs-%e5%8f%98%e9%87%8f)

## 1. 用法

有时，脚本需要在执行过程中，由用户提供一部分数据，这时候可以使用 `read` 命令。
它将用户输入存入一个变量，方便后面代码使用，用户按下回车键，表示输入结束。

`read` 命令格式如下：
```
# options 是参数选项
# variable 是用来保存输入数值的一个或多个变量名，如果没提供，环境变量 REPLY 会包含用户输入的一整行数据
read [-options] [variable...]
```

如果用户输入项
少于 `read` 命令给出的变量数目，那么额外的变量值为空,
多余给出的数量，则多余的部分都被塞到最后一个变量里。

[例子](./scripts/script04.sh)
```
./scripts/script04.sh
```

`read` 命令除了读取键盘输入外，还可以用来读取文件。

通过 `read` 命令，读取一个文件的内容。
`done` 命令后面的定向符 `<`，
将文件导向 `read` 命令，每次读取一行，
存入变量 `myline`，直到文件读取完毕。

```sh
while read myline
do
  echo "$myline"
done < $filename
```

## 2. 参数

### 2.1 -t

超时秒数，如果用户超过了设置的秒数，仍未输入，脚本放弃等待，继续向下执行。

[例子](./scripts/script05.sh)
```
./scripts/script05.sh
```

### 2.2 -p

指定用户输入的提示信息
```sh
read -p "Enter one or more values > "
echo "REPLY = '$REPLY'"
```

### 2.3 -a

把用户的输入赋值给一个数组，从零号位置开始
[例子](./scripts/script06.sh)
```
./scripts/script06.sh
```

### 2.4 -n

指定只读取若干个字符为变量值，而不是整行读取。
```sh
# 读取三个字符
read -n 3 letter
# 输出：abcdefghij
echo $letter
# 输出：abc
```

### 2.5 -e

允许用户输入时，使用 `readline` 库提供的快捷键，比如自动补全。

### 2.6 其他参数

- `-d` 只读取一个字符做为变量
- `-r` raw 模式，不把用户输入的反斜杠解释为转义符
- `-s` 使i用户输入不显示在屏幕上，常用于输入密码
- `-u fd` 使用文件描述符 `fd` 做为输入。[维基百科](https://zh.wikipedia.org/wiki/%E6%96%87%E4%BB%B6%E6%8F%8F%E8%BF%B0%E7%AC%A6)

## 3. IFS 变量

`read` 命令读取值，默认是以空格分隔。
可以通过自定义环境变量 `IFS`（内部字段分隔符，Internal Field Separator 缩写）修改分隔符标志。

[例子](./scripts/script07.sh)

如果 `IFS` 是空字符串，就等同整行读入一个变量。
```sh
#!/bin/bash
input="/path/to/txt/file"
while IFS= read -r line
do
  echo "$line"
done < "$input"
```