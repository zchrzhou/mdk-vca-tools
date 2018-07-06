#!/bin/bash

###  Detect Node Info
#HOST_IP=172.31.x.254
#CARD_IDX=x
#NODE_IDX=x

CURRENT_DIR=`pwd`
. $CURRENT_DIR/lib/whoami.sh 

STARTUP_LOG=/tmp/vca_${CARD_IDX}${NODE_IDX}_boot.log
echo "[vca_${CARD_IDX}${NODE_IDX}] start `date`" > $STARTUP_LOG 

function setup_bash
{
    cp -f $CURRENT_DIR/dot-bash_profile /root/.bash_profile
    cp -f $CURRENT_DIR/dot-bashrc /root/.bashrc

    echo "[vca_${CARD_IDX}${NODE_IDX}] 1 bash okay." >> $STARTUP_LOG 
}

function setup_ssh
{
    mkdir -p /root/.ssh
    cp -f $CURRENT_DIR/dot-ssh/* /root/.ssh/
    chmod 600 /root/.ssh/*

    echo "[vca_${CARD_IDX}${NODE_IDX}] 2 ssh okay." >> $STARTUP_LOG 
}

function setup_yum
{
    mkdir -p /root/tmp/yum.repos.d
    mv /etc/yum.repos.d/* /root/tmp/yum.repos.d/

    ## setup local yum repo
    cat > /etc/yum.repos.d/vv.repo <<EOF
[host]
name=host
baseurl=http://${HOST_IP}/centos71
gpgcheck=0
EOF

    ## install package
    yum -y install git
    yum -y install nfs-utils

    echo "[vca_${CARD_IDX}${NODE_IDX}] 3 yum okay." >> $STARTUP_LOG 
}

function setup_ntp
{
    yum -y install --disablerepo=* --enablerepo=host ntp

    sed -i -e 's/^server/#server/' /etc/ntp.conf
    echo server $HOST_IP >> /etc/ntp.conf

    systemctl enable  ntpd
    systemctl restart ntpd

    echo "[vca_${CARD_IDX}${NODE_IDX}] 4 ntp okay." >> $STARTUP_LOG 
}

function setup_nfs
{
    mkdir -p $VCASHARE_ROOT
    mount -t nfs $HOST_IP:/home/lmsdk/vca-share $VCASHARE_ROOT

    echo "[vca_${CARD_IDX}${NODE_IDX}] 5 nfs okay." >> $STARTUP_LOG 
}

function setup_hevc
{
    pushd $VCASHARE_ROOT/install/HEVC2015
    ./install.sh -s setup.cfg
    popd   

    echo "[vca_${CARD_IDX}${NODE_IDX}] 6 hevc okay." >> $STARTUP_LOG 
}

function setup_okapi
{
    ln -sf $VCASHARE_ROOT/okapi/okapi.py /usr/bin/zzvca
    chmod +x $VCASHARE_ROOT/okapi/okapi-core/*.sh

    echo "[vca_${CARD_IDX}${NODE_IDX}] 7 okapi okay." >> $STARTUP_LOG 
}

function setup_time
{
    if [ -f $VCASHARE_ROOT/run/time/sync.sh ]; then
        pushd $VCASHARE_ROOT/run/time
        chmod +x ./sync.sh
        ./sync.sh
        popd
    fi

    echo "[vca_${CARD_IDX}${NODE_IDX}] 8 time okay." >> $STARTUP_LOG 
}

function setup_stats
{
    mkdir -p $VCASHARE_ROOT/run/tmp/card${CARD_IDX}

    rm -rf /tmp/card${CARD_IDX}
    ln -sf $VCASHARE_ROOT/run/tmp/card${CARD_IDX} /tmp/

    ## for LD_LIBRARY_PATH
    ln -sf /VCA/monitor/node/bin/libcttmetrics.so /usr/lib64/

    echo "[vca_${CARD_IDX}${NODE_IDX}] 9 stats okay." >> $STARTUP_LOG 
}

function setup_log
{
    echo "[vca_${CARD_IDX}${NODE_IDX}] all finished." >> $STARTUP_LOG 
    cp -f $STARTUP_LOG  $VCASHARE_ROOT/run/boot
}

setup_bash
setup_ssh
setup_yum
setup_ntp
setup_nfs
setup_hevc
setup_okapi
setup_time
setup_stats
setup_log
