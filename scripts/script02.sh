#!/bin/bash

echo "一共输入了 $# 个参数"

# while 语法
while [ "$1" != "" ];do
  echo "剩下 $# 个参数"
  echo "参数：$1"
  shift
done