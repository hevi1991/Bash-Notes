# 目录堆栈

- [目录堆栈](#%e7%9b%ae%e5%bd%95%e5%a0%86%e6%a0%88)
  - [1. cd -](#1-cd)
  - [2. pushd，popd](#2-pushdpopd)
  - [3. dirs 命令](#3-dirs-%e5%91%bd%e4%bb%a4)

## 1. cd -

回到上一次位置
```
# 去用户主目录
cd ~
#返回上一次目录
cd -
```

## 2. pushd，popd

如果希望记忆多重目录，可以用 `pushd` 和 `popd` 命令，用来操作目录堆栈。

`pushd` 用法类似 `cd` 可以进入指定目录
```
pushd dir
```

`popd` 不带参数（带参数估计用不上）
```
popd 移除当前堆栈顶部记录，然后回去栈顶目录
```

## 3. dirs 命令

`dirs` 命令可以显示目录堆栈的内容，一般查看 `pushd` 和 `popd` 操作后的结果。

它支持以下参数
- `-c` 清空目录栈
- `-l` 打印完整目录
- `-p` 逐行打印
- `-v` 每条记录前加编号（从编号零开始）
- `+N` 堆栈由顶算起到第 `N` 个目录，从零算起
- `-N` 堆栈由底算起到第 `N` 个目录，从零算起