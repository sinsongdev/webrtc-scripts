#!/bin/bash

SERVER_HOST=IP.
SERVER_PORT=8080
GOOGLE_APP_ENGINE_PATH=/usr/bin/dev_appserver.py
APPRTC_SERVER_PATH=/home/ubuntu/apprtc/apprtc/out/app_engine

if [ $# -eq 0 ] ; then

  app_engine="`ps ax|grep -v grep |grep dev_appserver |wc -l`"
  echo $app_engine

  if [ "$app_engine" -eq "0" ] ; then
        echo "start.."
        $GOOGLE_APP_ENGINE_PATH  --host=$SERVER_HOST --port=$SERVER_PORT $APPRTC_SERVER_PATH &
  elif [ "$app_engine" -eq "1" ] ; then
        echo "running.."
       app_engine_cnt="`netstat -anpt | grep LISTEN | grep python |wc -l`"
        echo $app_engine_cnt
       if [ "$app_engine_cnt" -gt "200" ] ; then
        ps -ef | grep python | grep -v grep | awk '{print "kill -9 "$2}' | sh -v
        $GOOGLE_APP_ENGINE_PATH  --host=$SERVER_HOST --port=$SERVER_PORT $APPRTC_SERVER_PATH &
       fi

       app_engine_cnt="`netstat -anpt | grep ESTABLISHED | grep collidermain |wc -l`"
       echo $app_engine_cnt
       if [ "$app_engine_cnt" -gt "200" ] ; then
        ps -ef | grep python | grep -v grep | awk '{print "kill -9 "$2}' | sh -v
        $GOOGLE_APP_ENGINE_PATH  --host=$SERVER_HOST --port=$SERVER_PORT $APPRTC_SERVER_PATH &
       fi
  else
        echo "restart.."
        ps -ef | grep python | grep -v grep | awk '{print "kill -9 "$2}' | sh -v
        $GOOGLE_APP_ENGINE_PATH  --host=$SERVER_HOST --port=$SERVER_PORT $APPRTC_SERVER_PATH &
  fi
else
  echo $1
  if [ "$1" == "restart" ] ; then
        ps -ef | grep python | grep -v grep | awk '{print "kill -9 "$2}' | sh -v
        $GOOGLE_APP_ENGINE_PATH  --host=$SERVER_HOST --port=$SERVER_PORT $APPRTC_SERVER_PATH &
  elif [ "$1" == "stop" ] ; then
        ps -ef | grep python | grep -v grep | awk '{print "kill -9 "$2}' | sh -v
  fi
fi

