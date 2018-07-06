#!/bin/bash

if [ $EUID -ne 0 ]; then
    echo "[zzdemo] Please run this command with root user."
    exit 1
fi

CARD_IDX=$1
case "$CARD_IDX" in
    "card0")
        echo "[zzdemo] Run 4k on card0"
        ssh 172.31.1.1 "zzvca 4k ${@:2}" &
        ssh 172.31.2.1 "zzvca 4k ${@:2}" &
        ssh 172.31.3.1 "zzvca 4k ${@:2}" &
        ;;

    "card1")
        echo "[zzdemo] Run 4k on card1"
        ssh 172.31.4.1 "zzvca 4k ${@:2}" &
        ssh 172.31.5.1 "zzvca 4k ${@:2}" &
        ssh 172.31.6.1 "zzvca 4k ${@:2}" &
        ;;

    * )
        echo "[zzdemo] Use `basename $0` [card0|card1]"
        ;;
esac
