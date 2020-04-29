#/bin/bash

read -p "Enter a number > " input

INT=$input

# 注意，字符串判断时，变量要放在双引号之中
# 如果不放在双引号之中，变量为空时，命令会变成[ -n ]，这时会判断为真。如果放在双引号之中，[ -n "" ]就判断为伪。

if [ -z "$INT" ]; then
  echo "INT is empty." >&2
  exit 1
fi
if [ $INT -eq 0 ]; then
  echo "INT is zero."
else
  if [ $INT -lt 0 ]; then
    echo "INT is negative."
  else
    echo "INT is positive."
  fi
  if [ $((INT % 2)) -eq 0 ]; then
    echo "INT is even."
  else
    echo "INT is odd."
  fi
fi