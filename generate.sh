#!/bin/bash

SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"

DREAMKAS_F=dreamkasF
KASSA_F=kassaF
PULSE_FA=pulseFA
SPUTNIK_F=sputnikF
DREAMKAS_RB=dreamkasRb
PATCH=dirPatch.tar

args=("$@")
KKT_TYPE=${args[0]}

createPack(){
    if [ -d "$1" ]
    then
        if [ -f "$1/$PATCH" ]
        then
            rm $1/$PATCH
        fi
        $SETCOLOR_SUCCESS
        cd $1
        tar cvf $PATCH *
        cd -
        echo -n "Создание архива ($1/$PATCH) ..."
        if [ $? -eq 0 ];
        then
            $SETCOLOR_SUCCESS
            echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
            $SETCOLOR_NORMAL
            echo
            exit 0
        else
            $SETCOLOR_FAILURE
            echo -n "$(tput hpa $(tput cols))$(tput cub 6)[FAIL]"
            $SETCOLOR_NORMAL
            echo
        fi
    else
        $SETCOLOR_FAILURE
        echo -e "Файлы $1 отсутствуют!"
        $SETCOLOR_NORMAL
        echo
    fi
    exit 1
}

packToCreate(){
    case "$1" in
        1) echo
        createPack $DREAMKAS_F
        ;;

        2) echo
        createPack $KASSA_F
        ;;

        3) echo
        createPack $PULSE_FA
        ;;

        4) echo
        createPack $SPUTNIK_F
        ;;

        5) echo
        createPack $DREAMKAS_RB
        ;;

        *)  $SETCOLOR_FAILURE
        echo -e "Данная модель не поддерживается!"
        $SETCOLOR_NORMAL
        echo
        exit 1
        ;;
    esac
}

if [ $# -eq 0 ]
    then
        echo -e "Выберите ККТ:"
        echo -e "1 - Дримкас-Ф"
        echo -e "2 - Касса-Ф"
        echo -e "3 - Пульс-ФА"
        echo -e "4 - Спутник-Ф"
        echo -e "5 - Дримкас-РБ"

        read model

        clear

        packToCreate $model

elif [  $# -eq 1 ]
    then
        packToCreate $KKT_TYPE

else
	$SETCOLOR_FAILURE
	echo -e "Ожидается не более одного аргумента!"
	$SETCOLOR_NORMAL
	echo
        exit 1
fi

exit $?
