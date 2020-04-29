# Bash
Bash 是 unix 和 linux 系统的一种 Shell（命令行环境）。


# Shell
Shell 是一个程序，提供一个与用户对话的环境。环境只有一个命令提示符，让用户从键盘输入命令，所以又称为命令行环境（commandline，简写 CLI）。
Shell 是一个命令解释器，解释用户输入的命令。它支持变量、条件判断、循环操作等语法，用户通过 Shell 命令写出各种小程序，又称为脚本（Script）。脚本通过 Shell 的解释执行，而不通过编译。（解释型编程语言）。

只要能给用户提供命令行环境的程序，都可以看作Shell。
- Bourne Shell (sh)
- Bourne Again Shell (bash)
- csh
- tcsh
- ksh
- zsh
- fish

Bash 是目前最常用的 Shell。
可以通过以下命令查看当前的Shell。
```
$ echo $SHELL
```
可以通过以下命令查看本机所有的Shell
```
$ cat /etc/shells
```

可以通过直接输入 `/etc/shells` 中的 `/bin/` 后的简写，启用各种 Shell。