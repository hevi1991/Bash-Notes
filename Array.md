# 数组

数组（array）是一个包含多个值得变量。
成员的编号从 0 开始，数量没上线，也没要求成员被连续索引。

- [数组](#%e6%95%b0%e7%bb%84)
  - [1. 创建数组](#1-%e5%88%9b%e5%bb%ba%e6%95%b0%e7%bb%84)
  - [2. 读取数组](#2-%e8%af%bb%e5%8f%96%e6%95%b0%e7%bb%84)
    - [2.1 读取单个元素](#21-%e8%af%bb%e5%8f%96%e5%8d%95%e4%b8%aa%e5%85%83%e7%b4%a0)
    - [2.2 读取所有成员](#22-%e8%af%bb%e5%8f%96%e6%89%80%e6%9c%89%e6%88%90%e5%91%98)
    - [2.3 默认位置](#23-%e9%bb%98%e8%ae%a4%e4%bd%8d%e7%bd%ae)
  - [3. 数组的长度](#3-%e6%95%b0%e7%bb%84%e7%9a%84%e9%95%bf%e5%ba%a6)
  - [4. 提取数组序号](#4-%e6%8f%90%e5%8f%96%e6%95%b0%e7%bb%84%e5%ba%8f%e5%8f%b7)
  - [5. 提取数组成员](#5-%e6%8f%90%e5%8f%96%e6%95%b0%e7%bb%84%e6%88%90%e5%91%98)
  - [6. 追加数组成员](#6-%e8%bf%bd%e5%8a%a0%e6%95%b0%e7%bb%84%e6%88%90%e5%91%98)
  - [7. 删除数组](#7-%e5%88%a0%e9%99%a4%e6%95%b0%e7%bb%84)
  - [8. 关联数组](#8-%e5%85%b3%e8%81%94%e6%95%b0%e7%bb%84)

## 1. 创建数组

写法：
```
# ARRAY 是数组的变量名。
# INDEX 是索引，一个大于等于零的整数，也可以是算术表达式。
ARRAY[INDEX]=value
```

创建一个三个成员的数组
```sh
# 写法一
array[0]=val1
array[1]=val2
array[2]=val3

# 写法二
array=(val1 val2 val3)
# 指定索引，如果不指定，则是默认索引
array=(val2 [2]=val1 [1]=val3)

# 写法三
array=(
  val1
  val2
  val3
)
```

定义数组的时候，可以使用通配符。
```sh
# 把当前目录下，所有 MP3 结尾的文件，放在一个数组
mp3s=( *.mp3 )
```

## 2. 读取数组

### 2.1 读取单个元素

读取数组某个位置的成员，使用下面的语法
```sh
# i 是索引
# 大括号不可省略
echo ${array[i]}
```

### 2.2 读取所有成员

`@` 和 `*` 是数组的特殊索引，表示返回数组的所有成员。
```sh
foo=(a b c d e f g h i j)
echo ${foo[@]}
# or
echo ${foo[*]}
```

遍历数组
```bash
# 注意，遍历数组的时候，变量有没双引号，Bash 有区别，建议加上。
names=( Peter-Wang "Ali Alina Wang" San-Zhang "Si Li" )
for i in "${names[@]}"; do
  echo $i
done

# 上面输出 4 个元素
# 下面输出 7 个元素

for i in ${names[@]} ; do
  echo $i
done
```

拷贝数组
```sh
arr=(1 2 3 4 5)
arr2=("${arr[@]}" 6)
echo "${arr2[@]}"
```

### 2.3 默认位置

如果读取数组成员时，没指定读哪个位置，默认使用索引 `0`。
```sh
declare -a foo
foo=A
echo ${foo[0]}
```

## 3. 数组的长度

检查数组长度，语法。
```sh
arr=(1 2 3)

${#arr[@]}
# or
${#arr[*]}
```

注意，用此语法去读某个元素的长度时，写法如下：
```sh
arr[100]=foo
${#arr[100]}
# 输出 3
```

## 4. 提取数组序号

提取数组中，有值的数组序号
```sh
arr=([5]=a [9]=b [23]=c)

${!arr[@]}

#or

${!arr[*]}
```

遍历数组有值元素例子：
```sh
arr=([5]=a [9]=b [23]=c)
for i in ${!arr[@]}; do
  echo ${arr[i]}
done
```

## 5. 提取数组成员

`${array[@]:position:length}` 的语法可以提取数组成员。
```sh
food=( apples bananas cucumbers dates eggs fajitas grapes )
echo ${food[@]:1:1}
# 输出 bananas

echo ${food[@]:1:3}
# 输出 bananas cucumbers dates

# 可以不输入长度，截取 position 后全部
echo ${food[@]:4}
# 输出 eggs fajitas grapes
```

## 6. 追加数组成员

可是使用 `+=` 赋值运算，自动追加到数组末尾。
```sh
foo=(a b c)
foo+=(d e f)
echo ${foo[@]}
# 输出 a b c d e f
```

## 7. 删除数组

删除一个数组成员。注意：不影响索引。

以下办法：
- 使用 `unset` 命令（推荐）
- 对目标下标赋值为空值

```sh
foo=(a b c d)
# unset
unset foo[2]
echo ${foo[@]}
# 输出 a b d

# 赋空值
foo[2]=''
echo ${foo[@]}
# 输出 a b

# 输出数组头部成员
foo=''
echo ${foo[@]}
# 输出 b
```

删除整个数组。
```sh
arr=(a b c)
unset arr
```

[含赋值下标删除的例子](./scripts/script17.sh)

## 8. 关联数组

新版本可以声明关联数组，实现非整数索引（类似编程语言中的Map）。
```sh
declare -A colors
colors["red"]="#ff0000"
colors["green"]="#00ff00"
colors["blue"]="#0000ff"
```

旧版本无法使用，暂不记录。