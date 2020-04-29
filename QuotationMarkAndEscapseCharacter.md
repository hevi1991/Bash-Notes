# 引号和转义

- [引号和转义](#%e5%bc%95%e5%8f%b7%e5%92%8c%e8%bd%ac%e4%b9%89)
  - [1. 转义](#1-%e8%bd%ac%e4%b9%89)
  - [2. 单引号](#2-%e5%8d%95%e5%bc%95%e5%8f%b7)
  - [3. 双引号](#3-%e5%8f%8c%e5%bc%95%e5%8f%b7)
  - [4. Here 文档](#4-here-%e6%96%87%e6%a1%a3)
  - [5. Here 字符串](#5-here-%e5%ad%97%e7%ac%a6%e4%b8%b2)

Bash 只有一种数据类型，就是字符串。

## 1. 转义

某些字符再 Bash 里面有特殊含义（比如 `$`、`&`、`*`）。

```
# 想要输出$date，就必须加转义
echo \$date
```

`\` 本身也是特殊字符。
```
echo \\
```

`\` 除了用于转义外，还可以表示一些不可打印的字符，例如：
- `\b` 退格
- `\n` 换行
- `\r` 回车
- `\t` 制表符

```
echo "a\tb"
```

## 2. 单引号

Bash 允许字符串放在单引号或双引号之中，加以引用，否则字符串会被 Bash 自动扩展。
```
echo '*'
```

## 3. 双引号

双引号比单引号宽松，保留大部分特殊字符的本来含义，除了三个字符：`$`、`\`、反引号(`)，这三个符号在双引号中，会被自动扩展。
```
echo "$SHELL"
```

双引号还有一个作用，就是保存原始命令的输出格式。
```
echo $(cal)
# 对比区别
echo "$(cal)"
```

## 4. Here 文档

Here 文档是一种多行文本输入方法，格式：
```
# 以 << 开头，然后空格，写一个标记，然后填写内容，结束的时候输入标记。
<< token
content
token
```
这个标记内部，可以使用变量、扩展，如果不希望发生变量替换和通配符扩展，应该把标记使用单引号包起来。
```
foo='hello'
cat << __example__
$foo
"$foo"
'$foo'
__example__

# 对比区别

foo='hello'
cat << '__example__'
$foo
"$foo"
'$foo'
__example__
```

Here 文档的本质是重定向，把字符串重定向输出给某个命令，相当于包含了 `echo` 命令。
```
command << token
  string
token

# 等同于

$ echo string | command
```

## 5. Here 字符串

Here 文档的变体，格式
```
<<< string
```