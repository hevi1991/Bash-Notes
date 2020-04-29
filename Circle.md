#  循环

Bash 提供三种循环语法 `for`、`while` 和 `until`。

- [循环](#%e5%be%aa%e7%8e%af)
  - [1. while 循环](#1-while-%e5%be%aa%e7%8e%af)
  - [2. until 循环](#2-until-%e5%be%aa%e7%8e%af)
  - [3. for...in 循环](#3-forin-%e5%be%aa%e7%8e%af)
  - [4. for 循环](#4-for-%e5%be%aa%e7%8e%af)
  - [5. break，continue 关键字](#5-breakcontinue-%e5%85%b3%e9%94%ae%e5%ad%97)
  - [6. select 结构](#6-select-%e7%bb%93%e6%9e%84)

## 1. while 循环

符合条件就一直运行

语法：
```sh
while condition; do
  commands
done
```

循环条件 `condition` 可以使用 `test` 命令，跟 `if` 结构的判断条件写法一致。
```sh
number=0
while ["$number" -lt 10]; do
  echo "Number = $number"
  number=$((number + 1))
done
```

几种写法：
```sh
# 关键字 do 可以跟 while 不在同一行，分行写时，可以不需要分号。
while true
do
  echo 'Hello, While looping...'
done

# 也可以写成一行
while true; do echo 'Hi'; done

# 也可以 while 条件表达式执行命令
while echo 'ECHO'; do echo 'Hello'; done

# 条件执行结果，只看最后一个条件命令真伪，以下代码不会输出任何内容
while true;false; do echo 'Hello'; done
```

## 2. until 循环

语 `while` 循环想法，符合条件就退出，否则一直运行。（推荐使用 `while` 统一）

写法：
```sh
until condition; do
  commands
done

# until do 不放在一行
until condition
do
  commands
done

# 都放在一行
until condition; do commands done
```

## 3. for...in 循环

`for...in` 循环用于遍历列表的每一项。
```sh
for variable in list
do
  commands
done

# for in do 一行
for variable in list;do
  commands
done
```

例子：
```sh
# 输出三个值
for i in word1 word2 word3;do
  echo $i
done

# 列表可以通过子命令产生
count=0
for i in $(cat ~/.bash_profile);do
  count=$((count + 1))
  echo "Word $count ($i) contains $(echo -n $i | wc -c) characters"
done
```

`in list` 的部分，在脚本里可以省略，默认等于脚本的所有参数 `$@`。
但是为了可读性，最好不要省略。
```sh
for filename; do echo "$filename";done
# 等同于
for filename in "$@"; do echo "$filename";done
```

## 4. for 循环

`for` 循环还支持 C 语言的循环语法。

上面代码中，expression1 用来初始化循环条件，expression2 用来决定循环结束的条件，expression3 在每次循环迭代的末尾执行，用于更新值。

注意，循环条件放在双重圆括号之中。另外，圆括号之中使用变量，不必加上美元符号$。
```sh
for (( expression1; expression2; expression3)); do
  cammands
done

# 等同于
(( expression1 ))
while ((expression2)); do
  commands
  ((expression3))
done
```

例子：
```sh
for (( i=0; i<5; i=i+1 )); do
  echo $i
done

# for 条件部门三个语句，都可以省略。
# 用户输入 . 就结束循环
for ((;;))
do
  read var
  if [ "$var" = "." ]; then
    break
  fi
done

```

## 5. break，continue 关键字

`break` 关键字立刻退出循环。
`continue` 结束本轮循环，继续下一轮。

## 6. select 结构

`select` 结构主要用来生成简单菜单。
语法与 `for...in` 循环基本一致。
```sh
select name in list
do
  commands
done
```

Bash 会对 select 依次进行下面的处理。

select 生成一个菜单，内容是列表 list 的每一项，并且每一项前面还有一个数字编号。
Bash 提示用户选择一项，输入它的编号。
用户输入以后，Bash 会将该项的内容存在变量 name，该项的编号存入环境变量 REPLY。如果用户没有输入，就按回车键，Bash 会重新输出菜单，让用户选择。
执行命令体 commands。
执行结束后，回到第一步，重复这个过程。

例子1
```sh
select brand in Samsung Sony iphone symphony Walton
do
  echo "You have chosen $brand"
done
```

配合 `case` 语法，根据不同选择执行不同任务。
[例子2](./scripts/script15.sh)
```
./scripts/script15.sh
```