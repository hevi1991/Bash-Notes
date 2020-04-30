# mktemp 和 trap 命令

Bash 脚本有时候需要创建临时文件或者临时目录。
常见做法是在 `/tmp` 目录里面创建文件或目录，这样做有很多弊端，使用 `mktemp` 命令是最安全的做法。

- [mktemp 和 trap 命令](#mktemp-%e5%92%8c-trap-%e5%91%bd%e4%bb%a4)
  - [1. 临时文件的安全问题](#1-%e4%b8%b4%e6%97%b6%e6%96%87%e4%bb%b6%e7%9a%84%e5%ae%89%e5%85%a8%e9%97%ae%e9%a2%98)
  - [2. mktemp 命令用法](#2-mktemp-%e5%91%bd%e4%bb%a4%e7%94%a8%e6%b3%95)
  - [3. mktemp 命令的参数](#3-mktemp-%e5%91%bd%e4%bb%a4%e7%9a%84%e5%8f%82%e6%95%b0)
  - [4. trap 命令](#4-trap-%e5%91%bd%e4%bb%a4)

## 1. 临时文件的安全问题

直接创建临时文件，尤其在 `/tmp` 目录里面，往往会导致安全问题。

`/tmp` 目录是所有人可读写，创建的临时文件也是所有人可读写。

生成临时文件应该遵循下面的规则。
- 创建前检查文件是否存在
- 确保临时文件已创建成功
- 临时文件必须有权限的限制
- 临时文件要使用不可预估的文件名
- 脚本退出时，要删除临时文件（使用 `trap` 命令）

## 2. mktemp 命令用法

`mktemp` 命令就是为了安全创建临时文件而设计的。
虽然在创建临时文件之前，它不会检查临时文件是否存在，
但是它支持唯一文件名和清除机制，因此可以减轻安全攻击的风险。

直接运行 `mktemp` 命令，就能生成一个临时文件。
```sh
mktemp
# 输出 /tmp/tmp.123asd13

# 查看临时文件权限
ls -l /tmp/tmp.123asd13
```

Bash 脚本使用 `mktemp` 命令的用法如下。
```sh
#!/bin/bash

# 确保程序退出后，删除临时文件
# 注意使用单引号
trap 'rm -f $TMPFILE' EXIT

# 确保文件创建成功，否则退出
TMPFILE=$(mktemp) || exit 1
echo "Our temp file is $TMPFILE"
```

## 3. mktemp 命令的参数

- `-d` 可以创建一个临时目录
- `-p` 可以指定临时文件所在目录
- `-t` 指定临时文件的文件名模板，模板的末尾必须至少包含三个连续的 `X` 字符。

## 4. trap 命令

`trap` 命令用来在 Bash 脚本中响应系统信号

最常见的系统信号就 SIGINT（中断），即按下 Ctrl + C 所产生的信号。

`trap -l` 可以列出所有的系统信号。
```
trap -l

1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
6) SIGABRT	 7) SIGBUS	 8) SIGFPE	 9) SIGKILL	10) SIGUSR1
11) SIGSEGV	12) SIGUSR2	13) SIGPIPE	14) SIGALRM	15) SIGTERM
16) SIGSTKFLT	17) SIGCHLD	18) SIGCONT	19) SIGSTOP	20) SIGTSTP
21) SIGTTIN	22) SIGTTOU	23) SIGURG	24) SIGXCPU	25) SIGXFSZ
26) SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGIO	30) SIGPWR
31) SIGSYS	34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
38) SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
43) SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
48) SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
53) SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
58) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
63) SIGRTMAX-1	64) SIGRTMAX
```

使用格式如下。
```
trap [动作] [信号 1] [信号 2]...
```

常用信号：
- `HUP`：编号 1，脚本与所在的终端脱离联系。
- `INT`：编号 2，用户按下 Ctrl + C，意图让脚本中止运行。
- `QUIT`：编号 3，用户按下 Ctrl + 斜杠，意图退出脚本。
- `KILL`：编号 9，该信号用于杀死进程。
- `TERM`：编号 15，这是 kill 命令发出的默认信号。
- `EXIT`：编号 0，这不是系统信号，而是 Bash 脚本特有的信号，不管什么情况，只要退出脚本就会产生。

注意，`trap` 命令必须放在脚本开头，否则它上方的任何命令导致脚本退出，都不会被它捕获。

如果 `trap` 需要触发多条命令，可以封装 Bash 函数。
```sh
function egress {
  command1
  command1
  command1
}

trap exgress EXIT
```