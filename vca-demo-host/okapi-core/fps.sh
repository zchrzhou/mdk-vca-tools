#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
. $SCRIPT_DIR/sample.sh 

CARD_IDX=1

zzdemo stats card${CARD_IDX} restart
zzdemo 1080p card${CARD_IDX} restart

echo "Transcode & Stats on Node is okay."
