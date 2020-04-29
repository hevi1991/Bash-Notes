#!/bin/bash

foo=(0 [1]=3 [3]=5 [7]=9 [11]=13 [15]=17)

echoFoo() {
  # 输出有值索引
  echo "indexes: ${!foo[@]}"
  # 输出有值成员
  echo -e "values: ${foo[@]} \n"
}

echoFoo

# 删除下标 1
echo "delete foo index 1 : ${foo[1]}"
unset foo[1]
echoFoo

# 删头
echo "delete foo index 0 : ${foo[0]}"
foo=
echoFoo

# 删所有
unset foo
echoFoo