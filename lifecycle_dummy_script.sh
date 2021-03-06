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
		log "[INSTALL] Installing $SVCNAME"
		;;
    deploy)
		log "[DEPLOY] Deploying $SVCNAME"
		;;
    configure)
		log "[CONFIGURE] Configuring $SVCNAME"
		;;
    start)
		if [ ! -z "$cliqrUserScript" -a -f "$cliqrUserScript" ]; then
		log "[START] Invoking pre-start user script"
		$cliqrUserScript 1 $cliqrUserScriptParams
		fi
		log "[START] Starting $SVCNAME"
		if [ ! -z $cliqrUserScript -a -f $cliqrUserScript ]; then
		log "[START] Invoking post-start user script"
		$cliqrUserScript 2 $cliqrUserScriptParams
		fi
		# Run restore script in case of migration
		if [ "$appMigrating" == "true" ]; then
		runMigrationRestoreScript
		fi
		log "[START] $SVCNAME successfully started."
		;;
    stop)
		log "[STOP] Invoking pre-stop user script"
		if [ ! -z $cliqrUserScript -a -f $cliqrUserScript ]; then
		$cliqrUserScript 3 $cliqrUserScriptParams
		fi
		log "[STOP] Stopping $SVCNAME"
		log "[STOP] Invoking post-stop user script"
		if [ ! -z $cliqrUserScript -a -f $cliqrUserScript ]; then
		$cliqrUserScript 4 $cliqrUserScriptParams
		fi
		log "[STOP] $SVCNAME successfully stopped."
		;;
    restart)
		log "[RESTART] Invoking pre-restart user script"
		if [ ! -z $cliqrUserScript -a -f $cliqrUserScript ]; then
		$cliqrUserScript 5 $cliqrUserScriptParams
		fi
		log "[RESTART] Restarting $SVCNAME"
		log "[RESTART] Invoking post-restart user script"
		if [ ! -z $cliqrUserScript -a -f $cliqrUserScript ]; then
		$cliqrUserScript 6 $cliqrUserScriptParams
		fi
		;;
    reload)
		log "[RELOAD] Invoking pre-reload user script"
		if [ ! -z $cliqrUserScript -a -f $cliqrUserScript ]; then
		$cliqrUserScript 7 $cliqrUserScriptParams
		fi
		log "[RELOAD] Reloding $SVCNAME settings"
		log "[RELOAD] Invoking post-reload user script"
		if [ ! -z $cliqrUserScript -a -f $cliqrUserScript ]; then
		$cliqrUserScript 8 $cliqrUserScriptParams
		fi
		log "[RELOAD] $SVCNAME successfully reloaded."
		;;
    cleanup)
		;;
    upgrade)
		log "[UPGRADE] Upgrading."
		;;
    *)
		log "[ERROR] unknown command"
		exit 127
		;;
esac