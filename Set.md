# Set 命令

- [Set 命令](#set-%e5%91%bd%e4%bb%a4)
  - [1 简介](#1-%e7%ae%80%e4%bb%8b)
  - [2。 set -u](#2-set--u)
  - [3. set -x](#3-set--x)
  - [4. Bash 错误处理](#4-bash-%e9%94%99%e8%af%af%e5%a4%84%e7%90%86)
  - [5. set -e](#5-set--e)
  - [6. set -o pipefail](#6-set--o-pipefail)
  - [7. 其他参数](#7-%e5%85%b6%e4%bb%96%e5%8f%82%e6%95%b0)
  - [8. 总结](#8-%e6%80%bb%e7%bb%93)
  - [9. shopt 命令](#9-shopt-%e5%91%bd%e4%bb%a4)

## 1 简介

Bash 执行脚本时，会创建一个子 Shell。
```
bash script.sh
```

上面`script.sh` 是在一个子 Shell 里面执行。
这个子 Shell 就是脚本的执行环境， Bash 默认给定这个环境的各种参数。

`set` 命令就是用来修改子 Shell 环境的运行参数，即定制环境。

[完整可定制清单](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html)。

直接运行 `set` 命令，会显示所有环境变量和 Shell 函数。
```sh
set
```

## 2。 set -u

对应 `set -o nounset`。

执行脚本时，如果遇到不存在的变量，Bash 默认忽略。
```sh
#!/usr/bin/env bash

echo $a
echo bar
```

上面代码，`$a` 是一个不存在的变量。执行结果如下。
```
bash script.sh

bar
```

假如加上 `set -u`，脚本遇到不存在的变量时，就会报错提醒，并停止执行。
```sh
#!/usr/bin/env bash
set -u

echo $a
echo bar
```
输出
```
bash script.sh
bash: script.sh:行4: a: 未绑定的变量
```

## 3. set -x

对应 `set -o xtrace`。

默认情况下，脚本执行后，只输出运行结果，没有其他内容。
如果多个命令连续执行，它们的运行结果就会连续输出。
有时会分不清，某一段内容是什么命令产生的。
```sh
#!/usr/bin/env bash
# 打开提醒
set -x
echo bar

# 关闭提醒
set +x
echo bar
```
输出如下
```
bash script.sh
+ echo bar
bar
```

## 4. Bash 错误处理

如果脚本里面有运行失败的命令（返回值非 0），Bash 默认会继续执行后面的命令。

为了防止错误累积，这时，一般采用下面写法。
```sh
command || exit 1
```

上面写法表示 `command` 有非 0 返回值，脚本就会停止执行。

## 5. set -e

对应 `set -o errexit`。

配置了 `set -e`，可以使脚本只要发生错误，就终止执行。
弥补[上一节](#4-bash-%e9%94%99%e8%af%af%e5%a4%84%e7%90%86)的单独处理
```sh
#!/usr/bin/env bash
# 打开异常终止程序
set -e
foo
echo bar

# 关闭异常终止脚本
set +e
```

## 6. set -o pipefail

`set -e` 防止不了管道命令。

所谓管道命令，就是多个子命令通过管道运算符（`|`）组合成为一个大的命令。
**Bash 会把最后一个子命令的返回值，作为整个命令的返回值。**
也就是说，只要最后一个子命令不失败，管道命令总是会执行成功，因此它后面命令依然会执行，`set -e` 就失效了。

例子：
```sh
#!/usr/bin/env bash
set -eo pipefail

foo | echo a
echo bar
```

## 7. 其他参数

- `set -n` 等同于 `set -o noexec`，不运行命令，只检查语法是否正确。
- `set -f` 等同于 `set -o noglob`，表示不对通配符进行文件名扩展。关闭 `set +f`。
- `set -v` 等同于 `set -o verbose`，表示打印 Shell 接收到的每一行输入。关闭 `set +v`。

## 8. 总结

上面常见命令，一般放在一起用。
```sh
# 写法一，一般写在脚本头部
set -euxo pipefail
# 写法二，在调用脚本的时候，传入set 参数
bash -euxo pipefail script.sh
```

## 9. shopt 命令

Bash 特有，用法与 Set 类似，详情：
https://wangdoc.com/bash/set.html#shopt-%E5%91%BD%E4%BB%A4