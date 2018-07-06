#!/bin/bash

## source environment for node
#HOST_IP=172.31.x.254
#CARD_IDX=x
#NODE_IDX=x
#VCASHARE_ROOT=x

## source whoami.sh
. /zach/lib/whoami.sh 

case "$1" in
    "start")
        pushd $VCASHARE_ROOT/perf-script
        perl main.pl ${@:2} &
        popd
        ;;
    "stop")
        killall perl sample_multi_transcode_drm
        ;;
    "restart")
        killall perl sample_multi_transcode_drm

        pushd $VCASHARE_ROOT/perf-script
        perl main.pl ${@:2} &
        popd
        ;;
    "status")
        ps -ef | grep -e sample_multi_transcode_drm -e main.pl  | grep -v grep
        ;;
    *)
        echo "Usage: `basename $0` [start|stop|restart|status]"
        ;;
esac
