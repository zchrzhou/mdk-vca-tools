#!/bin/bash

## source environment for node
#HOST_IP=172.31.x.254
#CARD_IDX=x
#NODE_IDX=x
#VCASHARE_ROOT=x

## source whoami.sh
. /zach/lib/whoami.sh 

TRANSCODE_BIN=$VCASHARE_ROOT/app/_build/latest/transcode_CQP_${CARD_IDX}${NODE_IDX}
INPUT_FILE=$VCASHARE_ROOT/input/4K_${CARD_IDX}${NODE_IDX}.h264
OUTPUT_FILE=$VCASHARE_ROOT/output/4K_${CARD_IDX}${NODE_IDX}.h265
FPS_LOG=$VCASHARE_ROOT/fps/fps_4K_${CARD_IDX}${NODE_IDX}.log

case "$1" in
    "start")
        $TRANSCODE_BIN -p $FPS_LOG -i::h264 $INPUT_FILE -o::h265 $OUTPUT_FILE -u 7 -b 15000 -pe e5400a06c74d41f5b12d430bbaa23d0b -w 3840 -h 2160 > /dev/null &
        ;;
    "stop")
        killall transcode_CQP_${CARD_IDX}${NODE_IDX}
        ;;
    "restart")
        killall transcode_CQP_${CARD_IDX}${NODE_IDX}
        $TRANSCODE_BIN -p $FPS_LOG -i::h264 $INPUT_FILE -o::h265 $OUTPUT_FILE -u 7 -b 15000 -pe e5400a06c74d41f5b12d430bbaa23d0b -w 3840 -h 2160 > /dev/null &
        ;;
    "status")
        ps -ef | grep transcode_CQP_${CARD_IDX}${NODE_IDX} | grep -v grep
        ;;
    *)
        echo "Usage: `basename $0` [start|stop|restart|status]"
        ;;
esac
