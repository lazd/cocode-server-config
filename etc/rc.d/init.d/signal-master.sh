#!/bin/sh
 
#
# chkconfig: 35 99 99
# description: Node.js /home/nodejs/sample/app.js
#
 
. /etc/rc.d/init.d/functions

NODE_ENV="production" 
USER="nodejs"
 
DAEMON="/usr/local/bin/node"
ROOT_DIR="/home/nodejs/"
 
SERVER="$ROOT_DIR/signal-master/server.js"
LOG_FILE="$ROOT_DIR/signal-master.log"
 
LOCK_FILE="/var/lock/subsys/signal-master"
 
do_start()
{
        if [ ! -f "$LOCK_FILE" ] ; then
                echo -n $"Starting $SERVER: "
                runuser -l "$USER" -c "NODE_ENV=$NODE_ENV $DAEMON $SERVER >> $LOG_FILE &" && echo_success || echo_failure
                RETVAL=$?
                echo
                [ $RETVAL -eq 0 ] && touch $LOCK_FILE
        else
                echo "$SERVER is locked."
                RETVAL=1
        fi
}
do_stop()
{
        echo -n $"Stopping $SERVER: "
        pid=`ps -aefw | grep "$DAEMON $SERVER" | grep -v " grep " | awk '{print $2}'`
        kill -9 $pid > /dev/null 2>&1 && echo_success || echo_failure
        RETVAL=$?
        echo
        [ $RETVAL -eq 0 ] && rm -f $LOCK_FILE
}
 
case "$1" in
        start)
                do_start
                ;;
        stop)
                do_stop
                ;;
        restart)
                do_stop
                do_start
                ;;
        *)
                echo "Usage: $0 {start|stop|restart}"
                RETVAL=1
esac
 
