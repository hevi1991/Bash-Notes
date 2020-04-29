#!/bin/bash

# -n 不换行
echo -n "输入一些文本 > "
read text
echo "你输入了：$text"
echo -n "输入几个参数，用空格隔开 > "
read a b c d
echo "你输入了 $a, $b, $c, $d"