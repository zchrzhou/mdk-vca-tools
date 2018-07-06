#!/bin/bash

if [ $EUID -ne 0 ]; then
    echo "[zzdemo] Please run this command with root user."
    exit 1
fi

ssh 172.31.1.1 "zzvca transcode $1" &
ssh 172.31.2.1 "zzvca transcode $1" &
ssh 172.31.3.1 "zzvca transcode $1" &
