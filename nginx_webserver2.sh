#!/bin/bash
exec
> >(tee -a /usr/local/osmosix/logs/service.log) 2>&1
echo
"Executing service script.."
.
/usr/local/cliqr/etc/userenv
#
main entry
case
$1 in
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