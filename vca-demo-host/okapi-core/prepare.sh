#!/bin/bash

if [ $EUID -ne 0 ]; then
    echo "[zzdemo] Please run this command with root user."
    exit 1
fi

CARD_IDX=$1
case "$CARD_IDX" in
    "card0")
        echo "[zzdemo] Run prepare on card0"
        ssh 172.31.1.1 "pushd /zach; bash ./vca_node_cfg.sh; popd"
        ssh 172.31.2.1 "pushd /zach; bash ./vca_node_cfg.sh; popd"
        ssh 172.31.3.1 "pushd /zach; bash ./vca_node_cfg.sh; popd"
        ;;

    "card1")
        echo "[zzdemo] Run prepare on card1"
        ssh 172.31.4.1 "pushd /zach; bash ./vca_node_cfg.sh; popd"
        ssh 172.31.5.1 "pushd /zach; bash ./vca_node_cfg.sh; popd"
        ssh 172.31.6.1 "pushd /zach; bash ./vca_node_cfg.sh; popd"
        ;;

    * )
        echo "[zzdemo] Use `basename $0` [card0|card1]"
        ;;
esac


echo "[zzdemo] all prepare are okay."
