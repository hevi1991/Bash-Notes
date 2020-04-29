# 条件判断

- [条件判断](#%e6%9d%a1%e4%bb%b6%e5%88%a4%e6%96%ad)
  - [1. if 结构](#1-if-%e7%bb%93%e6%9e%84)
  - [2. test 命令](#2-test-%e5%91%bd%e4%bb%a4)
  - [3. 判断表达式](#3-%e5%88%a4%e6%96%ad%e8%a1%a8%e8%be%be%e5%bc%8f)
    - [3.1 文件判断](#31-%e6%96%87%e4%bb%b6%e5%88%a4%e6%96%ad)
    - [3.2 字符串判断](#32-%e5%ad%97%e7%ac%a6%e4%b8%b2%e5%88%a4%e6%96%ad)
    - [3.3 整数判断](#33-%e6%95%b4%e6%95%b0%e5%88%a4%e6%96%ad)
    - [3.4 正则判断](#34-%e6%ad%a3%e5%88%99%e5%88%a4%e6%96%ad)
    - [3.5 test 判断的逻辑运算](#35-test-%e5%88%a4%e6%96%ad%e7%9a%84%e9%80%bb%e8%be%91%e8%bf%90%e7%ae%97)
    - [3.6 算术判断](#36-%e7%ae%97%e6%9c%af%e5%88%a4%e6%96%ad)
    - [3.7 普通命令的逻辑运算](#37-%e6%99%ae%e9%80%9a%e5%91%bd%e4%bb%a4%e7%9a%84%e9%80%bb%e8%be%91%e8%bf%90%e7%ae%97)
  - [4. case 结构](#4-case-%e7%bb%93%e6%9e%84)

## 1. if 结构

主要分为三个部分：`if`、`elif`、`else`。其中后面两个是可选的。
`elif` 可以有多个。

语法：
```sh
if commands; then
  commands
elif commands; then
  commands...
elif commands; then
  commands...
else
  commands
fi
```

`if` 关键字后面是主要的判断条件，`elif` 用来添加主条件不成立时的其他判断，`else` 则是所有条件都不成立才执行的部分。

例子：
```sh
if test $USER = "foo"; then
  echo "Hello foo."
else
  echo "You are not foo."
fi
```

`if` 和 `then` 写在同一行时，需要分号隔开。
分号是 Bash 的命令分隔符。
它们也可以写成两行，这时不需要分号：
```sh
if true
then
  echo 'Hello world'
fi
```

也可以写成单行：
```sh
if true;then echo 'Hello world';fi
```

注意，`if` 关键字后面也可以使一条命令，该命令 [执行成功（返回值 `0`）](./Script.md#9-exit-%e5%91%bd%e4%bb%a4)，
就表示判断条件成立。
```sh
if echo 'hi';then echo 'hello world';fi
```

`if` 后面可以跟任意数量的命令。
这时，所有命令都会执行，但判断真伪只看最后一个命令，
即使前面所有命令都失败，只要最后一个命令返回 `0`，就会执行 `then` 部分。
```sh
if false;true;then echo 'hello';fi

# 可以配合逻辑运算符控制命令执行
if false && echo 'hello';then echo 'world';fi
```

## 2. test 命令

`if` 结构的判断条件，一般使用 `test` 命令，有三种形式。

三种形式是等价的。
```sh
# expression 为表达式
# 1)
test expression

# 2) 注意空格
[ expression ]

# 3) 注意空格，支持正则表达式
[[ expression ]]
```
表达式为真， `test` 命令执行成功（返回值为 `0`），
表达式为否， `test` 命令执行失败（返回值为 `1`）。

例子，判断 `/etc/hosts` 是否是 [文件](#31-%e6%96%87%e4%bb%b6%e5%88%a4%e6%96%ad)：
```sh
test -f /etc/hosts
echo $?

# or
[ -f /etc/hosts ]
echo $?
```

下面把 `test` 命令的三种形式，用在 `if` 结构中，判断一个文件/文件夹是否存在：
```sh
# 1)
if test -e /tmp/foo.txt ; then
  echo 'Found foo.txt'
fi

# 2)
if [ -e /tmp/foo.txt ] ; then
  echo 'Found foo.txt'
fi

# 3)
if [[ -e /tmp/foo.txt ]] ; then
  echo 'Found foo.txt'
fi
```

## 3. 判断表达式

`if` 关键字后面，跟的是一个命令。
这个命令可以是 `test` 命令，也可以是其他命令。
命令的返回值为 `0` 表示判断成立，否则表示不成立。
因为这些命令主要是为了得到返回值，所以可以视为表达式。

### 3.1 文件判断

以下表达式用来判断文件状态：
- [ -a file ]：如果 file 存在，则为 true。
- [ -b file ]：如果 file 存在并且是一个块（设备）文件，则为 true。
- [ -c file ]：如果 file 存在并且是一个字符（设备）文件，则为 true。
- [ -d file ]：如果 file 存在并且是一个目录，则为 true。
- [ -e file ]：如果 file 存在，则为 true。
- [ -f file ]：如果 file 存在并且是一个普通文件，则为 true。
- [ -g file ]：如果 file 存在并且设置了组 ID，则为 true。
- [ -G file ]：如果 file 存在并且属于有效的组 ID，则为 true。
- [ -h file ]：如果 file 存在并且是符号链接（`ln`），则为 true。
- [ -k file ]：如果 file 存在并且设置了它的“sticky bit”，则为 true。
- [ -L file ]：如果 file 存在并且是一个符号链接，则为 true。
- [ -N file ]：如果 file 存在并且自上次读取后已被修改，则为 true。
- [ -O file ]：如果 file 存在并且属于有效的用户 ID，则为 true。
- [ -p file ]：如果 file 存在并且是一个命名管道，则为 true。
- [ -r file ]：如果 file 存在并且可读（当前用户有可读权限），则为 true。
- [ -s file ]：如果 file 存在且其长度大于零，则为 true。
- [ -S file ]：如果 file 存在且是一个网络 socket，则为 true。
- [ -t fd ]：如果 fd 是一个文件描述符，并且重定向到终端，则为 true 。 这可以用来判断是否重定向了标准输入／输出错误。
- [ -u file ]：如果 file 存在并且设置了 setuid 位，则为 true。
- [ -w file ]：如果 file 存在并且可写（当前用户拥有可写权限），则为 true。
- [ -x file ]：如果 file 存在并且可执行（有效用户有执行／搜索权限），则为 true。
- [ file1 -nt file2 ]：如果 FILE1 比 FILE2 的更新时间最近，或者 FILE1 存在而 FILE2 不存在，则为 true。
- [ file1 -ot file2 ]：如果 FILE1 比 FILE2 的更新时间更旧，或者 FILE2 存在而 FILE1 不存在，则为 true。
- [ FILE1 -ef FILE2 ]：如果 FILE1 和 FILE2 引用相同的设备和 inode 编号，则为 true。

[例子](./scripts/script08.sh)

### 3.2 字符串判断

以下表达式判断字符串（注意空格）：
- `[ string ]` 如果 string 不为空（长度大于 0），则判断为真。
- `[ -n string ]` 如果字符串 string 的长度大于零，则判断为真。
- `[ -z string ]` 如果字符串 string 的长度为零，则判断为真。
- `[ string1 = string2 ]` 如果 string1 和 string2 相同，则判断为真。
- `[ string1 == string2 ]` 等同于 [ string1 = string2 ]。
- `[ string1 != string2 ]` 如果 string1 和 string2 不相同，则判断为真。
- `[ string1 '>' string2 ]` 如果按照字典顺序 string1 排列在 string2 之后，则判断为真。
- `[ string1 '<' string2 ]` 如果按照字典顺序 string1 排列在 string2 之前，则判断为真。

[例子](./scripts/script09.sh)

### 3.3 整数判断

下面表达式用于判断整数：
- [ integer1 -eq integer2 ]：如果 integer1 等于 integer2，则为 true。
- [ integer1 -ne integer2 ]：如果 integer1 不等于 integer2，则为 true。
- [ integer1 -le integer2 ]：如果 integer1 小于或等于 integer2，则为 true。
- [ integer1 -lt integer2 ]：如果 integer1 小于 integer2，则为 true。
- [ integer1 -ge integer2 ]：如果 integer1 大于或等于 integer2，则为 true。
- [ integer1 -gt integer2 ]：如果 integer1 大于 integer2，则为 true。

[例子](./scripts/script10.sh)

### 3.4 正则判断

`[[ expression ]]` 这种判断形式，支持正则表达式。
```sh
[[ string1 =~ regex ]]
```

例子：
```sh
INT=-5
if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
  echo "INT is an integer."
  exit 0
else
  # >&2 输出到 stderr
  echo "INT is not an integer." >&2
  exit 1
fi
```

### 3.5 test 判断的逻辑运算

通过逻辑运算，可以把多个 test 判断表达式结合起来，创造更复杂的判断。
三种逻辑运算 AND，OR，和 NOT，都有自己的专用符号。

- `AND` 运算：符号 `&&`，也可使用参数 `-a`。
- `OR` 运算：符号 `||`，也可使用参数 `-o`。
- `NOT` 运算：符号 `!`。

使用否定操作符 `!` 时，最好用圆括号确定转义的范围。
上面例子中，`test` 命令内部使用的圆括号，必须使用引号或者转义，否则会被 Bash 解释。
```sh
if [ ! \( $INT -ge $MIN_VAL -a $INT -le $MAX_VAL \) ]; then
    echo "$INT is outside $MIN_VAL to $MAX_VAL."
else
    echo "$INT is in range."
fi
```

### 3.6 算术判断

Bash 提供了 `((...))` 做为 [算术](./Arithmetic.md) 条件判断。
注意，算术判断不需要使用 `test` 命令，而是直接使用 `((...))` 结构。
```sh
if (( foo = 5 ));then echo "foo is $foo"; fi
```

算术判断 `1` 为真，`0` 为否。

例子：
```sh

INT=-5

if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
  if ((INT == 0)); then
    echo "INT is zero."
  else
    if ((INT < 0)); then
      echo "INT is negative."
    else
      echo "INT is positive."
    fi
    if (( ((INT % 2)) == 0)); then
      echo "INT is even."
    else
      echo "INT is odd."
    fi
  fi
else
  echo "INT is not an integer." >&2
  exit 1
fi
```

### 3.7 普通命令的逻辑运算

如果 if 结构使用的不是 test 命令，而是普通命令，
比如上一节的 `((...))` 算术运算，或者 `test` 命令与普通命令混用，
那么可以使用 `Bash` 的命令控制操作符 `&&（AND）` 和 `||（OR）`，进行多个命令的逻辑运算。

[具体详情](./BasicSyntax.md#5%e5%91%bd%e4%bb%a4%e7%9a%84%e7%bb%84%e5%90%88%e7%ac%a6--%e5%92%8c)
[例子](./scripts/script11.sh)

## 4. case 结构

`case` 结构用于多值判断，可以为每个值指定对应命令，跟包含多个 `elif` 和 `if` 结构等价，但语义更好。
语法如下：
```sh
# expression 表达式
case expression in
  # pattern 表达式的值
  pattern )
    commands ;;
  pattern )
    commands ;;
  # ... 可重复添加
esac
```

[例子 1](./scripts/script12.sh)
```
./scripts/script12.sh
```

[例子 2](./scripts/script13.sh)
```
./scripts/script13.sh
```

`case` 的匹配模式可以使用各种 [通配符](./ModeExpand.md)，
下面是一些例子：
- `a)` 匹配 a
- `a|b)` 匹配 a 和 b
- `[[:alpha:]])` 匹配单个字母
- `???)` 匹配三个字符
- `*.txt)` 匹配 `.txt` 结尾
- `*)` 匹配任意输入

Bash 4.0 之后，`case` 结构支持匹配多个条件，语法是 `;;&` 终结每个条件块。
```
read -n 1 -p "输入一个字符 > "

echo
case $REPLY in
  [[:upper:]])    echo "'$REPLY' is upper case." ;;&
  [[:lower:]])    echo "'$REPLY' is lower case." ;;&
  [[:alpha:]])    echo "'$REPLY' is alphabetic." ;;&
  [[:digit:]])    echo "'$REPLY' is a digit." ;;&
  [[:graph:]])    echo "'$REPLY' is a visible character." ;;&
  [[:punct:]])    echo "'$REPLY' is a punctuation symbol." ;;&
  [[:space:]])    echo "'$REPLY' is a whitespace character." ;;&
  [[:xdigit:]])   echo "'$REPLY' is a hexadecimal digit." ;;&
esac
```