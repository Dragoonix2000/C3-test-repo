#!/bin/bash
exec > >(tee -a /usr/local/osmosix/logs/service.log) 2>&1
OSSVC_HOME=/usr/local/osmosix/service
. /usr/local/osmosix/etc/.osmosix.sh
. /usr/local/osmosix/etc/userenv
. $OSSVC_HOME/utils/cfgutil.sh
. $OSSVC_HOME/utils/install_util.sh
. $OSSVC_HOME/utils/os_info_util.sh
cmd=$1
SVCNAME="dummy"
SVCHOME="$OSSVC_HOME/$SVCNAME"
USER_ENV="/usr/local/osmosix/etc/userenv"

case $cmd in
    install)
		sudo apt-get update
		sudo apt-get install -y nginx
		sudo apt-get install -y unzip
		;;
    deploy)
		wget $nginxAppFile
		sudo unzip /opt/remoteFiles/nginxAppFile/$nginxAppZip -d /opt/remoteFiles/nginxAppFile/
		sudo mkdir /etc/nginx/www
		sudo cp /opt/remoteFiles/nginxAppFile/index.html /etc/nginx/www/index.html
		sudo cp /opt/remoteFiles/nginxAppFile/nginx.conf /etc/nginx/nginx.conf
		sudo systemctl restart nginx.service
		;;
    configure)
		;;
    start)
		;;
    stop)
		;;
    restart)
		sudo systemctl restart nginx.service
		;;
    reload)
		;;
    cleanup)
		;;
    upgrade)
		;;
    *)
		exit 127
		;;
esac