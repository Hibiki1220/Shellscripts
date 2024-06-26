#!/bin/bash
name=0113
echo -e "\e[1;33m $name \e[0m"
while :
do
    read -p "ファイル名を入力 : " filename
    case $filename in
        [Ee][Nn][Dd]) echo "終了します" 
        break ;;
        *) 
        if [ -e $filename ] ; then
            if [ -f $filename ] ; then
                f=file
            else
                f=directory
            fi
            if [ -r $filename ] ; then
                r=read
            else
                r=""
            fi
            if [ -w $filename ] ; then
                w=write
            else
                w=""
            fi
            if [ -x $filename ] ; then
                x=execute
            else
                x=""
            fi
            echo "$filename は　$f です。アクセス権は $r $w $x です。"
            if [ $f = file ] ; then
                read -p "バックアップを作成しますか？ : " copy
                case $copy in
                    [Yy][Ee][Ss]|[Yy]) cp $filename $filename\.1
                    continue ;;
                    [Nn][Oo]|[Nn]) continue ;;
                esac
            else
                read -p "ディレクトリ内のリストを表示しますか？" ans1
                case $ans1 in
                    [Yy][Ee][Ss]|[Yy]) ls ./$filename/
                    continue ;;
                    [Nn][Oo]|[Nn])continue ;;
                esac
            fi
        else
            read -p "ファイルが存在しません。作成しますか？" ans2
            case $ans2 in
                [Yy][Ee][Ss]|[Yy])
                read -p "ファイルかディレクトリどちらで作成しますか？" ans3
                case $ans3 in
                    [Ff][Ii][Ll][Ee]|[Ff]) touch $filename ;;
                    [Dd][Ii][Rr]|[Dd]) mkdir $filename ;;
                esac
            esac
        fi
    esac
done
