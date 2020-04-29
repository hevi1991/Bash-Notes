#/bin/bash

# $0 脚本名
# $1 第一个参数
# $2 第二个参数
# $3 第三个参数

filename=$1
word1=$2
word2=$3

# 查找 $word1 和 $word2 是否同时存在于 $filename 文件中
if grep $word1 $filename && grep $word2 $filename
then
  echo "$word1 and $word2 are both in $filename."
fi