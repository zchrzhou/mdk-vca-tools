#!/bin/bash

## vca_wait <card-idx> <status>
function vca_wait
{
    echo "[zzdemo] wait card$1 $2:"
    until [[ "3" ==  "`vcactl status $1 | grep $2 | wc -l`" ]]; do
        echo -e -n "."
        sleep 1s
    done
    echo -e ""

}

## vca_wait_init <card-idx>
function vca_wait_init
{
    echo "[zzdemo] wait card$1 init:"
    if [[ -f /VCA/run/boot/vca_$1*_boot.log ]]; then
        until [[ "3" ==  "`grep finished /VCA/run/boot/vca_$1*_boot.log | wc -l`" ]]; do
            echo -e -n "."
            sleep 1s
        done
    fi
    echo -e ""
}
