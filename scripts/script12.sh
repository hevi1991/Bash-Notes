#!/bin/bash

read -p "输入一个1到3之间的数字（包含两端）> " charater

case $charater in
  # 中间有没括号都可以
  1 ) echo 1
  ## 必须 ;; 来结束
  ;;
  2 ) echo 2
  ;;
  3 ) echo 3
  ;;
  # 如果都不匹配，则输出这个
  * ) echo 输入不符合要求
esac