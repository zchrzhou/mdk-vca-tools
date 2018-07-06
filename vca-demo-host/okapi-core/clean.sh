#!/bin/bash

if [ $EUID -ne 0 ]; then
    echo "[zzdemo] Please run this command with root user."
    exit 1
fi

rm -rf /VCA/fps/*
rm -rf /VCA/output/*

echo "[zzdemo] Clean fps log & output done."
