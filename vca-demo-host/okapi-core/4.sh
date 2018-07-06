#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
. $SCRIPT_DIR/sample.sh 

CARD_IDX=1
 
zzdemo monitor card${CARD_IDX} restart
zzdemo 1080p-fps card${CARD_IDX}

echo "Transcode & Stats on Node is okay."
