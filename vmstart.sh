#!/bin/bash
# Title		: vmstart.sh
# Description	: Script to install nginx as a webserver
# Author	: Dragoonix2000
# Date		: 2021-27-05
# Version	: 0.1
# Usage		: bash vmstart.sh
# External Vars	: Read in at run time via global paramater - $MY_USER, $MY_KEY
# Internal Vars	: Initialized within srcipt - $CLIQR_HOME

# Source some cliqr variables and scripts
CLIQR_HOME=/usr/local/osmosix
. $CLIQR_HOME/etc/.osmosix.sh
. $CLIQR_HOME/etc/userenv
. $CLIQR_HOME/service/utils/cfgutil.sh
. $CLIQR_HOME/service/utils/install_util.sh
. $CLIQR_HOME/service/utils/os_info_util.sh

# Main
## Update apt-get

sudo apt-get update
sudo apt-get install nginx

#LOG VARIABELS
#touch /home/cliqruser/vmstart.txt
#echo -n $MY_KEY >> /home/cliqruser/vmstart.txt
#echo "##user##" >> /home/cliqruser/vmstart.txt
#echo -n $MY_USER >> /home/cliqruser/vmstart.txt


exit 0