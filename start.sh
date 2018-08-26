#!/bin/sh

#chkconfig: 123456 90 10
# openerp server for user authentication
workdir=/home/IPProxyPool

daemon_start() {
  cd $workdir
  nohup python -u IPProxy.py >> IPProxy.log 2>&1 &
  echo "IPProxy Server started."
}

daemon_stop() {
  pids=($(ps -ef | grep '[p]ython -u IPProxy.py' | awk '{ print $2 }'))
  echo ${pids[@]}
  
  for pid in ${pids[@]}; do kill $pid; done
  sleep 2
  echo "Server killed."
}

case "$1" in
start)
  daemon_start
;;

stop)
  daemon_stop
;;

restart)
  daemon_stop
  daemon_start
;;

*)
  echo "Usage: /odoo/odoo-8.0/openerp-server {start|stop|restart}"
 exit 1
;;
esac
exit 0
