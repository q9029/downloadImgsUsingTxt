#!/bin/bash
# downloadImgsFromTxt.sh
#
# 2016/03/08
# Haruyuki Ichino
#
# Description:
# テキストファイルに記述されているURLから画像をダウンロード
#
# Usage:
#   引数) ファイル名
#   Example:
#   $ bash downloadImgsFromTxt.sh sample.txt
# ---------------------------------------------------------

FILENAME=./$1
OUTPUT_DIR=output

binary_path=`dirname $0`

# try-catch
set -eu
trap catch ERR
function catch() {
        echo "[ERROR]Fail in "$0
}


# 出力ディレクトリの確認
if [ ! -e $binary_path/$OUTPUT_DIR ]; then
    mkdir -p $binary_path/$OUTPUT_DIR
fi

# 各URLにアクセス
declare -i i=0
while read line;
do
    echo $line
    filename=( `echo $line | awk -F / '{print $NF}'`)
    curl -o $binary_path/$OUTPUT_DIR/$filename $line
    i=$((i+1))
done < $FILENAME
