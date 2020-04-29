# 变量

- [变量](#%e5%8f%98%e9%87%8f)
  - [1. 简介](#1-%e7%ae%80%e4%bb%8b)
  - [2. 创建变量](#2-%e5%88%9b%e5%bb%ba%e5%8f%98%e9%87%8f)
  - [3. 读取变量](#3-%e8%af%bb%e5%8f%96%e5%8f%98%e9%87%8f)
  - [4. 删除变量](#4-%e5%88%a0%e9%99%a4%e5%8f%98%e9%87%8f)
  - [5. 输出变量，export 命令](#5-%e8%be%93%e5%87%ba%e5%8f%98%e9%87%8fexport-%e5%91%bd%e4%bb%a4)
  - [6. 特殊变量](#6-%e7%89%b9%e6%ae%8a%e5%8f%98%e9%87%8f)
  - [7. 变量的默认值](#7-%e5%8f%98%e9%87%8f%e7%9a%84%e9%bb%98%e8%ae%a4%e5%80%bc)
  - [8. declare 命令](#8-declare-%e5%91%bd%e4%bb%a4)
  - [9. readonly 命令](#9-readonly-%e5%91%bd%e4%bb%a4)
  - [10. let 命令](#10-let-%e5%91%bd%e4%bb%a4)

## 1. 简介

环境变量是 Bash 环境自带的变量，`env` 或 `printenv` 命令，可以显示所有变量。
```
env
# or
printenv
```

常见环境变量
- `BASHPID` Bash 进程ID
- `BASHOPTS` 当前 Shell 的参数，可以通过 `shopt` 命令修改
- `DISPLAY` 图形环境的显示器名字
- `EDITOR` 默认的文本编辑器
- `HOME` 用户的主目录
- `HOST` 当前主机名称
- `IFS` 词与词之间的分隔符，默认是空格
- `LANG` 字符集以及语言编码
- `PATH` 由冒号分开的目录列表，当输入可执行程序名后，会搜索这个目录列表
- `PS1` Shell 提示符
- `PS2` 输入多行命令时，次要的 Shell 提示符
- `PWD` 当前工作目录
- `RANDOM` 返回一个 0 到 32767 之间的随机数
- `SHELL` Shell 的名字
- `SHELLOPTS` 启动当前 Shell 的 `set` 命令参数
- `TERM` 终端类型名，即终端仿真器用的协议
- `UID` 当前用户的 ID 编号
- `USER` 当前用户的用户名

`set` 命令可以显示所有变量（包括环境变量和自定义变量），以及所有 Bash 函数。
```
set
```

## 2. 创建变量

用户创建变量时，变量名必须遵守下面规则：
- 字母、数字和下划线字符组成
- 第一个字符不能是数字
- 字母严格大小写
- 等号两边不能有空格
- 如果变量的值包含空格，必须放入引号中
- 赋值重复，后面会覆盖前面的值

```
variable=value
```

Bash 没有数据类型的概念，所有变量值都是字符串。
下面是一些自定义变量例子：
```
a=z
b="a string"
c="a string and $b"
d="\t\ta string\n"
e=$(ls -l foo.txt)
f=$((5 * 7))
```

## 3. 读取变量

读取变量的时候，直接在变量名前加 `$` 即可。
如果变量不存在， Bash 不会报错，而会输出空字符。
```
foo=bar
echo $foo
```

读取变量的时候，变量名可以使用花括号 `{}` 包围，比如 `$a` 可以写成 `${a}`。
这种写法可以用于变量名与其他字符连用的情况。

```
a=foo
echo $a_file
echo ${a}_file
```

如果变量的值本身也是变量，可以使用 `${!varname}` 的语法，读取最终的值。
```
myvar=USER
echo ${!myvar}
```

## 4. 删除变量

`unset` 命令来删除一个变量，或者将变量复制为空。
```
foo=bar

unset foo
# or
foo=
```

## 5. 输出变量，export 命令

用户创建的变量仅可用在当前Shell，子 Shell 默认读取不到父 Shell 定义的变量。为了把变量传递给子 Shell，需要使用 `export` 命令。
子 Shell 对该变量做修改，不影响父 Shell export 变量的值。
```
NAME=foo
export NAME

# or
export NAME=foo

# then
bash

echo $NAME
```

## 6. 特殊变量

- `$?` 为上一个命令的退出码，用来判断上一个命令是否执行成功。如果 `$?` 结果是 1，表示上一个命令执行失败
- `$$` 输出当前 Shell 的进程 ID
- `$_` 为上一个命令的最后一个参数
- `$!` 为最后一个后台执行的异步命令的进程 ID
- `$0` 当前 Shell 的名词，或者脚本名
- `$-` 当前的 Shell 启动参数
- `$@` 和 `$#` 表示脚本参数数量

## 7. 变量的默认值

Bash 提供四种语法与变量默认值有关。
- `${varname:-word}` 如果 varname 不存在，返回 word，否则返回 varname 的值
- `${varname:=word}` 如果 varname 不存在，设置 varname 的值为 word，并返回 varname
- `${varname:+word}` 如果 varname 不存在，返回 word，否则返回空值
- `${varname:?message}` 如果 varname 不存在， 打印 message，并中断脚本执行

在脚本中，可以用 1 到 9 来表示脚本的参数，1 就是第一个参数。
```
filename=${1:?"filename missing"}
# 表示第一个参数缺失
```

## 8. declare 命令

`declare` 命令可以声明一些特殊类型的变量，为变量设置一些限制，比如声明只读类型的变量和整数类型的变量。
语法如下：
```
declare OPTION VARIABLE=true
```

OPTION 主要参数如下：
- `-a` 声明数组变量
- `-f` 输出当前环境的所有函数定义
- `-F` 输出当前环境的所有函数名
- `-i` 声明整数变量
- `-l` 声明变量为小写字母，声明后，设值时都会被转为小写
- `-u` 声明变量为大写字母，声明后，设值时都会被转为大写
- `-p` 查看变量信息
- `-r` 声明只读变量
- `-x` 该变量输出位环境变量

`declare` 命令如果在函数中，声明的变量只在函数内部有效，等同于 `local` 命令。

不带任何参数时，`declare` 命令输出当前环境的所有变量，包含函数在内，等同于不带任何参数的 `set` 命令。

`-i` 参数声明整数变量后，可以直接进行数学运算，如果不设置 result 为整数类型，val1*val2 会被当成字面量：
```
declare -i val1=12 val2=5
declare -i result
result=val1*val2
echo $result
result2=val1*val2
echo $result2
```

`-x` 等同于 `export` 命令。
```
declare -x foo=bar
# equals
export foo=bar
```

`-r` 声明只读变量，无法改变变量值，也不能 `unset` 变量。
```
declare -r bar=1
bar=2
```

`-p` 打印变量信息。
```
declare -ir bar=100
declare -p bar
```

## 9. readonly 命令

设置变量只读，等同于`declare -r variable`。
```
# 设置 foo 只读，值为 1
readonly foo=1

# 打印当前环境下所有只读的变量
readonly -p
```

## 10. let 命令
`let` 命令声明变量时，可以直接执行算术表达式。
```
let foo=1+2
echo $foo
```

如果参数表达式包含空格，需要加引号。
```
let "foo = 1 + 2"
```

`let` 可以同时对多个变量赋值，赋值表达式之间用空格分隔。
```
let "v1=1" "v2=2" "v3=++v1"
echo $v1,$v2,$v3
```