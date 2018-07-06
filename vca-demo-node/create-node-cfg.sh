#!/bin/bash

echo "start ..."

VCA_NODE_CFG="vca-node-cfg.tar.gz"

rm -rf ./$VCA_NODE_CFG

pushd ./node-cfg
tar czvf ../$VCA_NODE_CFG *
popd

rm -f /var/www/html/vca-setting/$VCA_NODE_CFG
cp -f ./$VCA_NODE_CFG /var/www/html/vca-setting/

ls -l /var/www/html/vca-setting/$VCA_NODE_CFG

echo "end ..."
