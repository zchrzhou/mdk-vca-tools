#!/bin/bash

if [ $EUID -ne 0 ]; then
    echo "[zzdemo] Please run this command with root user."
    exit 1
fi

#TEST_LOG_DIR=~/test
#mkdir -p $TEST_LOG_DIR
#ssh 172.31.1.1 "zzvca test 2>&1"  > $TEST_LOG_DIR/1.log &
#ssh 172.31.2.1 "zzvca test 2>&1"  > $TEST_LOG_DIR/2.log &
#ssh 172.31.3.1 "zzvca test 2>&1"  > $TEST_LOG_DIR/3.log &

echo "[zzdemo] test on node 0 ..."
ssh 172.31.1.1 "zzvca test 2>&1"

echo "[zzdemo] test on node 1 ..."
ssh 172.31.2.1 "zzvca test 2>&1"

echo "[zzdemo] test on node 2 ..."
ssh 172.31.3.1 "zzvca test 2>&1"


echo "[zzdemo] test are okay."
