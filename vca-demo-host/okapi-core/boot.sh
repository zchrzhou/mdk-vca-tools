#!/bin/bash

if [ $EUID -ne 0 ]; then
    echo "[zzdemo] Please run this command with root user."
    exit 1
fi

rm -rf /root/.ssh/known_hosts

echo "[zzdemo] prepare for time sync"
hwclock --systohc
_MY_TIMEZONE=`ls -l /etc/localtime | sed -e 's@.*/\([^/]\+/[^/]\+\)$@\1@'`
_NOW=`date +%m%d%H%M%Y`

cat > /VCA/run/time/sync.sh <<EOF
#!/bin/bash

timedatectl set-timezone $_MY_TIMEZONE
date $_NOW
EOF

echo "[zzdemo] ln -sf /VCA/run/tmp/card{0,1} /tmp/"
mkdir -p /VCA/run/tmp/card{0,1}
ln -sf /VCA/run/tmp/card{0,1} /tmp/

echo "[zzdemo] boot image ..."
pushd /root/Projects/VCA/VCA_EXT_1.0.338
vcactl boot vca_baremetal_1.0.338.img
popd

echo "[zzdemo] Boot up image finished ..."
