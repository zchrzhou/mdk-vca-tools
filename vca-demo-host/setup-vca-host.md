Setup VCA host
===========================

1. Install CentOS 7.1 with "Server with GUI", create user: lmsdk
2. Yum, network proxy, sudo

        # cat /etc/yum.conf
        proxy=http://proxy-prc.*****.com:911


        # cat /etc/sudoers
        lmsdk   ALL=(ALL)       ALL

3. Copy VCA source to host machine

        $ scp  -r zhoujd@IP:Projects.tar.gz .
        $ tar xf Projects.tar.gz

        $ cd ~
        $ git clone zhoujd@IP:gitrepo/vca-share.git
        $ git clone zhoujd@IP:gitrepo/vca-demo-host.git
        $ git clone zhoujd@IP:gitrepo/vca-demo-node.git
        $ git clone zhoujd@IP:gitrepo/vca-gnuplot.git
        $ git clone zhoujd@IP:gitrepo/vca-msdk-samples.git

        # sudo su
        # ln -sf /home/lmsdk/vca-share /VCA
        # ln -sf /home/lmsdk/Projects /root
        # ln -sf /home/lmsdk/vca-demo-host /root
        # ln -sf /home/lmsdk/vca-demo-node /root
        

4. Close firewall

        ## close firewall
        # systemctl stop firewalld.service   # on CentOS7
        # systemctl disable firewalld.service

5. Install VNC Server


        # systemctl stop firewalld.service

        # yum install tigervnc-server tigervnc-server-module
        # cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service
        # cd /etc/systemd/system
        # vim vncserver@:1.service

        # systemctl enable vncserver@:1.service
        # vncpasswd
        # systemctl start vncserver@:1.service
        # systemctl status vncserver@:1.service
        # netstat -lnt | grep 590*
        # grep vnc /var/log/messages


6. Install Samba server

        # yum install samba samba-client samba-common
        # cat /etc/samba/smb.conf
        [lmsdk]
        comment = lmsdk
        path = /home/lmsdk
        browseable = yes
        writable = yes
        valid users = lmsdk

        # smbpasswd -a lmsdk
        # systemctl enable smb.service
        # systemctl enable nmb.service
        # systemctl start smb.service
        # systemctl start nmb.service


        # cat /etc/selinux/config
        SELINUX=disabled

        # reboot

7. Install httpd for local yum repo

        # mount -o loop <CentOS71.iso> /media/centos71

        # mkdir -p /var/www/html/centos71
        # mkdir -p /var/www/html/vca-setting

        # yum -y install --disablerepo=* --enablerepo=localbase httpd
        # systemctl enable httpd
        # systemctl start httpd

        # cp CentOS-LocalBase.repo /etc/yum.repos.d/
        # cp -r /media/centos71/* /var/www/html/centos71

8. Install VCA package

        # rpm -qa | grep -e daemon-vca -e vcass-modules | xargs yum -y erase 
	    # yum -y localinstall --disablerepo=* kernel-3*rpm 
	    # yum -y localinstall --disablerepo=* daemon-vca*rpm 
        # yum -y localinstall --disablerepo=* vcass-modules*rpm

	    # grub2-set-default 0
	    # reboot
	
9. Install NFS Server

        # yum -y install --disablerepo=* --enablerepo=localbase nfs-utils

        # cat /etc/exports
        /home/lmsdk/vca-share              *(rw,sync,no_root_squash,no_all_squash)

        # systemctl stop nfs-server
        # systemctl disable nfs-server
        # systemctl enable rpcbind
        # systemctl enable nfs-server
        # systemctl start rpcbind
        # systemctl start nfs-server

10. Install ntp Sever

        # yum -y install --disablerepo=* --enablerepo=localbase ntp

        TMP_FILE="ntp.conf"
        cp -f /etc/ntp.conf $TMP_FILE
        echo "server 127.0.0.1" >> $TMP_FILE
        echo "restrict 172.31.0.0 mask 255.255.0.0 nomodify notrap" >> $TMP_FILE
        # mv -f $TMP_FILE /etc/ntp.conf
        # systemctl restart ntpd
        # systemctl enable ntpd

11. Install gnuplot and fonts

        $ cd ~/vca-gnuplot
        $ ./install.sh
        
