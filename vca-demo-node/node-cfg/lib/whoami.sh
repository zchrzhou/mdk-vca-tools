#!/bin/bash

VCA_HOSTNAME=`hostname`


case "$VCA_HOSTNAME" in
    "vca_node_00")
        export HOST_IP=172.31.1.254
        export CARD_IDX=0
        export NODE_IDX=0
        ;;
    "vca_node_01")
        export HOST_IP=172.31.2.254
        export CARD_IDX=0
        export NODE_IDX=1
        ;;
    
    "vca_node_02")
        export HOST_IP=172.31.3.254
        export CARD_IDX=0
        export NODE_IDX=2
        ;;
    "vca_node_10")
        export HOST_IP=172.31.4.254
        export CARD_IDX=1
        export NODE_IDX=0
        ;;
    "vca_node_11")
        export HOST_IP=172.31.5.254
        export CARD_IDX=1
        export NODE_IDX=1
        ;;
    
    "vca_node_12")
        export HOST_IP=172.31.6.254
        export CARD_IDX=1
        export NODE_IDX=2
        ;;

esac

echo "[zzvca] I am Card $CARD_IDX Node $NODE_IDX"

export VCASHARE_ROOT=/VCA
echo "[zzvca] VCA share root: $VCASHARE_ROOT"
