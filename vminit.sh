#!/bin/bash
# Title		: vm-init.sh
# Description	: A script to do some CloudCenter node initialization stuff, e.g. create user, add keys, etc.
# Original author	: jasgrimm
# Expanded by: Dragoonix2000
# Date		: 2021-26-05
# Version	: 0.2
# Usage		: bash vminit.sh
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
## Create new user

if [ -d /home/$MY_USER ]; then
	sudo agentSendLogMessage "$MY_USER already exists."
else
	sudo useradd -m -d /home/$MY_USER $MY_USER
	sudo mkdir /home/$MY_USER/.ssh
	sudo chown $MY_USER:$MY_USER /home/$MY_USER/.ssh
	sudo chmod 700 /home/$MY_USER/.ssh
	sudo touch /home/$MY_USER/.ssh/authorized_keys
	sudo chown $MY_USER:$MY_USER /home/$MY_USER/.ssh/authorized_keys
	sudo chmod 600 /home/$MY_USER/.ssh/authorized_keys
	sudo agentSendLogMessage "New user $MY_USER created."
fi

#LOG VARIABELS
touch /home/cliqruser/test.txt
echo -n $MY_KEY >> /home/cliqruser/test.txt
echo "##user##" >> /home/cliqruser/test.txt
echo -n $MY_USER >> /home/cliqruser/test.txt

## Add user to sudoers

sudo usermod -aG wheel $MY_USER
sudo usermod -aG wheel cliqruser
sudo -i bash -c "echo \"$MY_USER  ALL= NOPASSWD: ALL\" >> /etc/sudoers"


## Insert keys for new user
sudo agentSendLogMessage "Adding a new key to cliqruser and $MY_USER authorized_keys..."
echo "## Dynamically inserted key ##" >> /home/cliqruser/.ssh/authorized_keys
echo -n $MY_KEY >> /home/cliqruser/.ssh/authorized_keys
sudo bash -c "echo \"## Dynamically inserted key ##\" >> /home/$MY_USER/.ssh/authorized_keys"
sudo bash -c "echo $MY_KEY >> /home/$MY_USER/.ssh/authorized_keys"

exit 0