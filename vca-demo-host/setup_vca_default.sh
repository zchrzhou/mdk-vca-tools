#!/bin/bash

### Add configure to /etc/vca_config.d/vca_xx_default.sh
case "$1" in
    "00")
        HOST_IP=172.31.1.254
        VCA_NODE_CFG="vca-node-cfg.tar.gz"
        TARGET_DIR=/zach
        VCA_SCRIPT=vca_node_cfg.sh
        ;;
    "01")
        HOST_IP=172.31.2.254
        VCA_NODE_CFG="vca-node-cfg.tar.gz"
        TARGET_DIR=/zach
        VCA_SCRIPT=vca_node_cfg.sh
        ;;
    "02")
        HOST_IP=172.31.3.254
        VCA_NODE_CFG="vca-node-cfg.tar.gz"
        TARGET_DIR=/zach
        VCA_SCRIPT=vca_node_cfg.sh
        ;;
    "10")
        HOST_IP=172.31.4.254
        VCA_NODE_CFG="vca-node-cfg.tar.gz"
        TARGET_DIR=/zach
        VCA_SCRIPT=vca_node_cfg.sh
        ;;
    "11")
        HOST_IP=172.31.5.254
        VCA_NODE_CFG="vca-node-cfg.tar.gz"
        TARGET_DIR=/zach
        VCA_SCRIPT=vca_node_cfg.sh
        ;;
    "12")
        HOST_IP=172.31.6.254
        VCA_NODE_CFG="vca-node-cfg.tar.gz"
        TARGET_DIR=/zach
        VCA_SCRIPT=vca_node_cfg.sh
        ;;
    * )
        echo "unknow command; use `basename $0` [00|01|02|XX]"
        exit 1
        ;;
esac

cat >> /etc/vca_config.d/vca_$1_default.sh <<EOF

## auto download node configure
mkdir -p $TARGET_DIR
for i in 1 2 3 4 5
do
    if [ ! -e $TARGET_DIR/$VCA_NODE_CFG ]; then
        sleep \$i
        wget http://$HOST_IP/vca-setting/$VCA_NODE_CFG -P $TARGET_DIR
    else
        pushd $TARGET_DIR
        tar xf $VCA_NODE_CFG
        chmod +x ./$VCA_SCRIPT
        ./$VCA_SCRIPT
        popd

        break
    fi
done
EOF
