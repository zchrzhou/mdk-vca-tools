#!/bin/bash

TIME_INTERVAL=1

case "$1" in
    "card0")
        CARD_IDX=0
        ;;
    "card1")
        CARD_IDX=1
        ;;
    * )
        echo "Usage: `basename $0` [card0|card1]"
        exit 1
        ;;
esac

while sleep $TIME_INTERVAL
do
    for i in 0 1 2; do
        if [[ -f /VCA/fps/fps_4K_${CARD_IDX}$i.log ]]; then
            echo "[card ${CARD_IDX} node $i] 4K transcode fps: `cat /VCA/fps/fps_4K_${CARD_IDX}$i.log | sed 's/.*,//g'`"
        fi
    done
done
