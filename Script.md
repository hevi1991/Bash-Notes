# Bash 脚本入门

- [Bash 脚本入门](#bash-%e8%84%9a%e6%9c%ac%e5%85%a5%e9%97%a8)
  - [1. Shebang 行](#1-shebang-%e8%a1%8c)
  - [2. 执行权限和路径](#2-%e6%89%a7%e8%a1%8c%e6%9d%83%e9%99%90%e5%92%8c%e8%b7%af%e5%be%84)
  - [3. env 命令](#3-env-%e5%91%bd%e4%bb%a4)
  - [4. 注释](#4-%e6%b3%a8%e9%87%8a)
  - [5. 脚本参数](#5-%e8%84%9a%e6%9c%ac%e5%8f%82%e6%95%b0)
  - [6. shift 命令](#6-shift-%e5%91%bd%e4%bb%a4)
  - [7. getopts 命令](#7-getopts-%e5%91%bd%e4%bb%a4)
  - [8. 配置项参数终止符 --](#8-%e9%85%8d%e7%bd%ae%e9%a1%b9%e5%8f%82%e6%95%b0%e7%bb%88%e6%ad%a2%e7%ac%a6)
  - [9. exit 命令](#9-exit-%e5%91%bd%e4%bb%a4)
  - [10. 命令执行结果](#10-%e5%91%bd%e4%bb%a4%e6%89%a7%e8%a1%8c%e7%bb%93%e6%9e%9c)
  - [11. source 命令](#11-source-%e5%91%bd%e4%bb%a4)
  - [12. 别名 alias 命令](#12-%e5%88%ab%e5%90%8d-alias-%e5%91%bd%e4%bb%a4)


> 脚本（script）就是包含一系列命令的一个文本文件。Shell 读取这个文件，依次执行里面的所有命令，就好像这些命令直接输入到命令行一样。所有能够在命令行完成的任务，都能够用脚本完成。
>脚本的好处是可以重复使用，也可以指定在特定场合自动调用，比如系统启动或关闭时自动执行脚本。

## 1. Shebang 行

脚本的第一行通常是指定解释器，即这个脚本必须通过什么解释器执行。

格式：`#!`后面接脚本解释器路径。
```
#!/bin/bash

# 或通过 env 去找

#!/usr/bin/env bash
```

## 2. 执行权限和路径

脚本需要有执行权限才可以被执行，可以使用 `chmod` 命令去赋予执行权限。

```
# 给所有用户执行权限
chmod +x script.sh

# 给所有用户读和执行权限
chmod +rx script.sh
# or 4读,2写,1执行
chmod 755 script.sh

# 只给脚本拥有者读和执权限
chmod u+rx script.sh
```

## 3. env 命令

`env` 命令总是指向 `/usr/bin/env` 文件，总在 `/usr/bin/` 目录下

`#!/usr/bin/env NAME` 这个语法的意思是，让 Shell 查找 `$PATH` 环境变量里面第一个匹配 `NAME`。

如果不知道某个命令的具体路径，或者希望兼容其他用户的机器，这样的写法就很有用。

支持如下参数：
- `-i`，`--ignore-environment` 不带环境变量启动
- `-u`，`--unset=NAME` 从环境变量中删除一个变量
- `--help` 显示帮助
- `--version` 输出版本信息

## 4. 注释

Bash 脚本中，`#` 表示注释，可以放在行首，也可以放在行尾。
```
# 这是注释
echo 'Something' # 井号后面也是注释
```

## 5. 脚本参数

调用脚本的时候，脚本文件名后面可以带有参数。
```
# 调用 script 脚本，word1、word2、word3 都是参数
script.sh word1 word2 word3
```

脚本文件内部，可以使用特殊变量，来引用这些参数

- `$0` 脚本文件名
- `$1` ~ `$9` 对应脚本第一到第九个参数，超过九个通过 `$n` ，n 为第几个参数
- `$#` 参数总数
- `$@` 全部参数（包括 `$0`），通过空格分隔

注意，
如果命令是 `command -o foo bar`，那么 
`-o` 是 `$1`，
`foo` 是 `$2`，
`bar` 是 `$3`

下面是一个脚本内部读取命令行参数的[例子](./scripts/script01.sh)：
```
# 调用
./scripts/script01.sh word1 word2 word3 word4 word5 word6 word7 word8 word9
```

## 6. shift 命令

`shift` 命令可以改变脚本参数，每次执行都会移除脚本当前的第一个参数（`$1`)，使后面的参数向前一位，即 `$2` 变成 `$1`、`$3` 变成 `$2`，以此类推。

`white` 循环结合 `shift` 命令，也可以读取每一个参数。
```
# 调用
./scripts/script02.sh word1 word2 word3 word4 word5 word6 word7 word8 word9
```
`shift` 默认参数为 1，即移除一位，可以修改参数调整。

## 7. getopts 命令

`getopts` 命令用于脚本内部，可以用来解析复杂的脚本命令行参数，通常与 `while` 循环一起使用，取出脚本所有的带前置连词 （`-`）的参数。
```
getopts optstring name
```

`optstring` 是字符串，给出脚本所有的连词参数，
比如某个脚本可以有三个配置项参数 `-l`、`-h`、`-a`，
其中只有 `-a` 可以带参数值，
而 `-l`、`-h` 是开关参数，

那么 `getopts` 的第一个参数写成 `lha:`，顺序不重要。
注意，`a` 后面有一个冒号，表示该参数有参数值，
`getopts` 规定带参数值的配置项参数，后面必须有一个冒号。

`getopts` 第二个参数 `name` 是一个变量名，用来保存当前取到的配置项参数，即 `l`、`h` 或 `a`。

[例子](./scripts/script03.sh)：
```
./scripts/script03.sh -lha hello   
```

变量OPTION保存的是，当前处理的那一个连词线参数（即`l` 、`h` 或 `a`）。
如果用户输入了没有指定的参数（比如 `-x`），那么 `OPTION` 等于 `?`。
循环体内使用 `case` 判断，处理这四种不同的情况。

如果某个连词线参数带有参数值，比如 `-a foo`，那么处理 `a` 参数的时候，环境变量 `$OPTARG` 保存的就是参数值。

注意，只要遇到不带连词线的参数，`getopts` 就会执行失败，从而退出 `while `循环。
比如，`getopts` 可以解析 `command -l foo`，但不可以解析 `command foo -l`。
另外，多个连词线参数写在一起的形式，比如 `command -lh`，`getopts` 也可以正确处理。

变量 `$OPTIND `在 `getopts `开始执行前是 `1`，然后每次执行就会加 `1`。
等到退出 `while` 循环，就意味着连词线参数全部处理完毕。

这时，`$OPTIND - 1` 就是已经处理的连词线参数个数，
使用 `shift` 命令将这些参数移除，保证后面的代码可以用 `$1`、`$2`等处理命令的主参数。

## 8. 配置项参数终止符 --

变量当作命令的参数时，有时希望指定变量只能做为实体参数，
不能当做配置项参数，这时可以用配置项参数终止符 `--`。
```
myPath="./scripts"
ls $myPath
ls -- $myPath

# 下面的例子会报错

myPath='-l'
ls $myPath
ls -- myPath
```

## 9. exit 命令

`exit` 命令用于终止当前脚本的执行，并向 `Shell` 返回一个退出值（脚本的返回值）。
```
exit
```

`exit` 后面可以加参数，简单来说，非零退出就认为执行出错
- `0` 正常退出
- `1` 发生错误
- `2` 用法不对
- `126` 不是可执行脚本
- `127` 命令没有发现

`exit` 与 `return` 命令的差别是，
`return` 命令是函数的退出，并返回一个值给调用者，脚本依然执行。
`exit` 是整个脚本的退出，如果在函数之中调用 `exit`，则退出函数，并终止脚本执行。

## 10. 命令执行结果

命令执行结束后，会有一个返回值。
`0` 表示执行成功，
非 `0` 表示执行失败。

环境变量 `$?` 可以读取前一个命令的返回值。
利用这点，可以在脚本中队命令执行结果进行判断。

例子
```bash
cd $somedir
# cd 成功时，删除其下所有文件
if [ "$?" = "0" ]; then
  rm *
else
  echo "无法切换目录！" 1>&2
  exit 1
fi
```

上面例子可改写成：
```bash
if cd $somedir; then
  rm *
else
  echo "无法切换目录" 1>&2
  exit 1
fi
```

使用逻辑运算符 `&&` 和 `||` 可以使写法更简洁：
```bash
cd $somedir && rm *
```

## 11. source 命令

`source` 命令用于执行一个脚本，通常用于重新加载一个配置文件。
```
source ~/.bashrc
```

`source` 命令有一个简写形式，可以用点（`.`）来表示
```
. ~/.bashrc
```

## 12. 别名 alias 命令

`alias` 命令用来为一个命令指定别名，便于记忆。

格式：
```
# NAME 对应别名
# DEFINITION 对应原始命令
alias NAME=DEFINITION
```

`alias` 也可以用来为长命令指定一个更短的别名。

例如定义一个 `today` 的命令
```
alias today='date +"%A, %B %-d, %Y"'
today
```

指定别名以后，就可以像使用其他命令一样使用别名。
一般来说，都会把常用的别名写在 `~/.bashrc` 的末尾。(MacOS 中添加到 `~/.bash_profile`)

直接调用 `alias` 命令，可以显示所有别名
```
alias
```

`unalias` 命令可以解除别名
```
# NAME 为别名
unalias NAME
```