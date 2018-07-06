#!/bin/bash

## source environment for node
#HOST_IP=172.31.x.254
#CARD_IDX=x
#NODE_IDX=x

## source whoami.sh
. /zach/lib/whoami.sh 

MONITOR_ROOT=$VCASHARE_ROOT/monitor/node/bin
MONITOR_BIN=SystemMonitor
#ADD_ARGS="-lograte 30"

export LD_LIBRARY_PATH=$MONITOR_ROOT:$LD_LIBRARY_PATH

case "$1" in
    "start")
        $MONITOR_ROOT/$MONITOR_BIN -logpath $VCASHARE_ROOT/run/tmp/card${CARD_IDX} $ADD_ARGS -nodeid $NODE_IDX > /dev/null &
        ;;
    "stop")
        killall $MONITOR_BIN 2>&1 > /dev/null
        #rm -rf $VCASHARE_ROOT/run/tmp/card${CARD_IDX}/*.dat
        ;;
    "restart")
        killall $MONITOR_BIN 2>&1 > /dev/null
        #rm -rf $VCASHARE_ROOT/run/tmp/card${CARD_IDX}/*.dat
        $MONITOR_ROOT/$MONITOR_BIN -logpath $VCASHARE_ROOT/run/tmp/card${CARD_IDX} $ADD_ARGS -nodeid $NODE_IDX > /dev/null &
        ;;
    "status")
        ps -ef | grep $MONITOR_BIN | grep -v grep
        ;;
    *)
        echo "Usage: `basename $0` [start|stop|restart|status]"
        ;;
esac
