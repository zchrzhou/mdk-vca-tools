#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
. $SCRIPT_DIR/sample.sh 

rm -rf /VCA/run/boot/*.log

vca_wait 0 "bios_up"
vca_wait 1 "bios_up"

zzdemo boot

vca_wait 0 "net_device_ready"
vca_wait 1 "net_device_ready"

vca_wait_init 0
vca_wait_init 1

echo "All Node is ready."
