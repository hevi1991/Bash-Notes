# 基本语法

- [基本语法](#%e5%9f%ba%e6%9c%ac%e8%af%ad%e6%b3%95)
  - [1. echo](#1-echo)
  - [2.命令格式](#2%e5%91%bd%e4%bb%a4%e6%a0%bc%e5%bc%8f)
  - [3.空格](#3%e7%a9%ba%e6%a0%bc)
  - [4.分号](#4%e5%88%86%e5%8f%b7)
  - [5.命令的组合符 && 和 ||](#5%e5%91%bd%e4%bb%a4%e7%9a%84%e7%bb%84%e5%90%88%e7%ac%a6--%e5%92%8c)
  - [6.type 命令](#6type-%e5%91%bd%e4%bb%a4)
  - [7.快捷键](#7%e5%bf%ab%e6%8d%b7%e9%94%ae)

## 1. echo
`echo` 命令作用是在屏幕输出一行文本，可以将参数原样输出。
```
echo hello world
```
如果需要输出多行文本，即包括换行符，则需要把文本放在引号内。
```
echo "hello
world"
```
`-n` 参数：默认情况，`echo` 输出的文本会在文末追加一个换行符，输入 `-n`，可以取消追加。
```
echo -n hello world
```
`-e` 参数：该参数会解释引号内的特殊字符，例如换行符`\n`。
```
echo -e "hello\nworld"
```

## 2.命令格式
命令行环境中，主要通过 Shell 命令，进行各种操作。 Shell 命令基本都是如下格式：
```
command [arg1 ... [ argN]]
```
有些参数是命令的配置项，一般以一个连词开头，例如：
```
ls -l
```
`-l` 是短形式（方便输入），`--list`是长形式（可读性好），作用完全相同。

Bash 单个命令一般都是一行，用户按回车即执行，有些命令比较差，写成多行利于阅读和编辑，这时候可以在每行结尾添加一个反斜杠，Bash 便会将下一行跟当前行放在一起解释：
```
echo foo \
bar
```

## 3.空格
Bash 通过空格（或 Tab 制表符）区分不同的参数。
```
command foo bar
```
如果参数之间有多个空格，Bash 会自动忽略多余的空格。

## 4.分号

分号 `;` 是命令的结束符，可以使一行可以放置多个命令，上一个命令执行结束后，再执行第二个命令。
```
clear;ls
```

## 5.命令的组合符 && 和 ||

通过组合符，控制命令之间的继发关系。

command1 运行成功后，运行 command2
```
command1 && command2
```

command1 运行失败的话，运行 command2
```
command1 || command2
```

例子：
command1 运行成功与否，command2 都会执行
```
command1 ; command2
```

command1 运行成功，command2 才执行
```
command1 && command2
```

command1 运行不成功，command2 才执行
```
command1 || command2
```

## 6.type 命令
`type` 命令用来判断命令的来源，若为 `builtin` 就是内部命令
```
type echo
```

## 7.快捷键

- ctrl + L 清除屏幕并将当前行移动到顶部，如同命令 `clear`
- ctrl + C 中止当前正在执行的命令
- ctrl + U 从光标位置删除到行首
- ctrl + K 从光标位置删除到行尾
- ctrl + D 关闭 Shell 会话