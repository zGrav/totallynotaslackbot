#!/bin/sh

# This assumes you have:
# 1) A user called hubot and paths manually set.
#
# To set the adapter either edit bin/hubot to specify what you want or append
# `-- -a slack` to the $DAEMON variable below.
#
### BEGIN INIT INFO
# Provides:          hubot
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the hubot service
# Description:       starts the Hubot bot for SLACK
### END INIT INFO

PATH=/home/hubot/totallynotaslackbot/node_modules:/home/hubot/totallynotaslackbot/node_modules/hubot/bin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
NAME="HUBOT - totallynotaslackbot"
HUBOT_ROOT="/home/hubot/totallynotaslackbot"
LOGFILE="/home/hubot/totallynotaslackbot/hubot.log_"
PIDFILE="/home/hubot/totallynotaslackbot/hubot.pid"
DAEMON="$HUBOT_ROOT/hubot"

export HUBOT_SLACK_TOKEN=xoxb-255734104787-AJRIoTALItzQ1smwCGCGtWku
export PORT=8081

yarn install

set -e

case "$1" in
  start)
        echo -n "Starting $NAME: "
	/sbin/start-stop-daemon --start --quiet --pidfile $PIDFILE --make-pidfile --background -C -d $HUBOT_ROOT --exec $DAEMON -- -a slack > $LOGFILE`date +"%d-%m-%Y"` 2>&1
        echo "."
        ;;
  debug)
	echo "Debug mode: no backgrounding"
        /sbin/start-stop-daemon --start --pidfile $PIDFILE --make-pidfile -d $HUBOT_ROOT --exec $DAEMON -- -a slack
        echo "."
        ;;
  stop)
        echo -n "Stopping $NAME: "
        /sbin/start-stop-daemon --stop --quiet --pidfile $PIDFILE
        echo "."
        ;;

   restart)
        echo -n "Restarting $NAME: "
        /sbin/start-stop-daemon --stop --quiet --pidfile $PIDFILE
	/sbin/start-stop-daemon --start --quiet --pidfile $PIDFILE --make-pidfile --background -C -d $HUBOT_ROOT --exec $DAEMON -- -a slack > $LOGFILE`date +"%d-%m-%Y"` 2>&1
        echo "."
        ;;

    *)
        echo "$NAME - Usage: {start|stop|debug|restart}" >&2
        exit 1
        ;;
    esac
    exit
