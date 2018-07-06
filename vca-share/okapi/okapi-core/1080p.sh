#!/bin/bash

## source environment for node
#HOST_IP=172.31.x.254
#CARD_IDX=x
#NODE_IDX=x
#VCASHARE_ROOT=x

## source whoami.sh
. /zach/lib/whoami.sh 

TRANSCODE_BIN=$VCASHARE_ROOT/app/_build/latest/transcode_AVC_${CARD_IDX}${NODE_IDX}
INPUT_FILE=$VCASHARE_ROOT/input/1080p_${CARD_IDX}${NODE_IDX}.h264
PAR_FILE=$VCASHARE_ROOT/input/1080p_${CARD_IDX}${NODE_IDX}.par
FPS_LOG=$VCASHARE_ROOT/fps/fps_1080p_${CARD_IDX}${NODE_IDX}.log


case "$1" in
    "start")
        $TRANSCODE_BIN -p $FPS_LOG -par $PAR_FILE > /dev/null &
        ;;
    "stop")
        killall transcode_AVC_${CARD_IDX}${NODE_IDX}
        ;;
    "restart")
        killall transcode_AVC_${CARD_IDX}${NODE_IDX}
        $TRANSCODE_BIN -p $FPS_LOG -par $PAR_FILE  > /dev/null &
        ;;
    "status")
        ps -ef | grep transcode_AVC_${CARD_IDX}${NODE_IDX} | grep -v grep
        ;;
    *)
        echo "Usage: `basename $0` [start|stop|restart|status]"
        ;;
esac
