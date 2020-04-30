#!/usr/bin/env bash

# 注意，必须使用单引号
trap 'rm -f $TMPFILE' EXIT

TMPFILE=$(mktemp) || exit 1
echo "Our temp file is $TMPFILE"