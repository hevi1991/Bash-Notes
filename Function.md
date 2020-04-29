# 函数

## 1. 简介

函数是可以重复使用的代码段，有利于代码的复用。

函数总是在当前 Shell 执行。

它与别名（alias）的区别在于，别名只适合封装简单的单个命令，函数则可以封装复杂的多行命令。

如果函数与别名同名，Shell 优先执行别名。

语法有两种：
```sh
# 函数名是 fn

# 第一种
fn() {
  # codes
}

# 第二种
function fn() {
  # codes
}

# 第二种不写括号也可以
function fn {
  # codes
}
```

简单函数调用例子。
```sh
hello() {
  echo "Hello $1"
}

# 调用
hello world
```

删除函数，可以用 `unset` 命令。
```sh
unset -f functionName
```

可以用 `declare` 查看函数定义
```sh
declare -f functionName
```

## 2. 参数变量

函数体内可以使用参数变量，获取函数参数。
函数的参数数量与脚本参数变量时一致的。
- `$1~$9` 函数的第一个到第9个的参数。
- `$0` 函数所在的脚本名。
- `$#` 函数的参数总数。
- `$@` 函数的全部参数，参数之间使用空格分隔。
- `$*` 函数的全部参数，参数之间使用变量$IFS值的第一个字符分隔，默认为空格，但是可以自定义。

## 3. return 命令

`return` 命令用于函数返回一个值。函数执行到这条命令就直接返回了。
`return` 后面可以不跟参数。
```sh
function func_return_value {
  return 10
}
```

函数将返回值返回给调用者。
如果命令行直接执行函数，下一个命令可以用 `$?` 取得返回值。

## 4. 全局变量和局部变量，local 命令

Bash 函数体内直接声明的变量，属于全局变量，整个脚本都可以读取。
```sh
fn () {
  foo=1
  echo "fn: foo = $foo"
}

fn
echo "global: foo = $foo"

# 输出
# fn: foo = 1
# global: foo = 1
```

函数体外声明的变量，函数体内依然可以修改。
```sh
foo=1

fn () {
  foo=2
}

echo $foo
```

函数里面可以使用 `local` 命令声明局部变量。
```sh
fn () {
  local foo
  foo=1
  echo "fn: foo = $foo"
}

fn
echo "global: foo = $foo"

# 输出
# fn: foo = 1
# global: foo =
```