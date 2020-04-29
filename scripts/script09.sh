#/bin/bash

read -p "Enter something > " input

ANSWER=$input

# 注意，字符串判断时，变量要放在双引号之中
# 如果不放在双引号之中，变量为空时，命令会变成[ -n ]，这时会判断为真。如果放在双引号之中，[ -n "" ]就判断为伪。

if [ -z "$ANSWER" ]; then
  echo "There is no answer." >&2
  exit 1
fi
if [ "$ANSWER" = "yes" ]; then
  echo "The answer is YES."
elif [ "$ANSWER" = "no" ]; then
  echo "The answer is NO."
elif [ "$ANSWER" = "maybe" ]; then
  echo "The answer is MAYBE."
else
  echo "The answer is UNKNOWN."
fi