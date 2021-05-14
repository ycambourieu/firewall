### BEGIN INIT INFO
# Provides:          firewall
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Script de gestion du firewall
# Description:       Gestion des règles iptables
### END INIT INFO

#!/bin/bash
firewall_dir="/etc/firewall"
log_dir="/var/log"
case "$1" in
	start)
		echo -n "Chargement des regles actives de firewall: "
		$firewall_dir/actif # >> $log_dir/firewall
		codeer=$(($codeer+$?))
		#
		if [ $codeer -eq "0" ]; then
			echo -e "[\033[32mOK\033[0m]"
		else
			echo -e "[\033[31mFAIL\033[0m]"
		fi
		;;
	stop)
		echo -n "Chargement des regles inactives de firewall: "
		$firewall_dir/inactif >> $log_dir/firewall
		codeer=$(($codeer+$?))
		#
		if [ $codeer -eq "0" ]; then
			echo -e "[\033[32mOK\033[0m]"
		else
			echo -e "[\033[31mFAIL\033[0m]"
		fi
		;;
	reload)
		echo -n "Rechargement des regles actives de firewall: "
		$firewall_dir/actif >> $log_dir/firewall
		codeer=$(($codeer+$?))
		#
		if [ $codeer -eq "0" ]; then
			echo -e "[\033[32mOK\033[0m]"
		else
			echo -e "[\033[31mFAIL\033[0m]"
		fi
		;;
	force-reload|restart)
		$0 stop
		sleep 0.1
		$0 start
		;;
	save)
		echo -n "sauvegarde de la configuration du firewall: "
		sauve_dir="backup-`date +%Y%m%d_%H%M%S`"
		mkdir $firewall_dir/$sauve_dir
		cp $firewall_dir/* $firewall_dir/$sauve_dir/ 2> /dev/null
		echo -e "[\033[32mOK\033[0m]"
		echo -e "La sauvegarde se trouve ici => \033[36m $firewall_dir/$sauve_dir\033[0m"
		;;
	*)
		echo "Usage: /etc/init.d/firewall *start|stop|restart|reload|force-reload*"
		exit 1
esac
exit 0

