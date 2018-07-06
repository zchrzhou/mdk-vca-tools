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
    echo "====== AVC 1080p multi-channel transcode ====="
    echo "=== node0 ===   === node1 ===   === node2 ===="
    paste /VCA/fps/fps_1080p_${CARD_IDX}{0,1,2}.log
done
