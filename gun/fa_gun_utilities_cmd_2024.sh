#!/bin/bash

count=0	

SERVICES[count]=fa_gun_radar_corr.service;
count=$((count + 1))

SERVICES[count]=fa_gun_trajectory.service;
count=$((count + 1))

SERVICES[count]=fa_gun_interface.service;
count=$((count + 1))

SERVICES[count]=fa_gun_fire_triangle.service;
count=$((count + 1))

SERVICES[count]=fa_gun_amqp2tcp.service;
count=$((count + 1))

SERVICES[count]=fa_gun_shutdowner.service;
count=$((count + 1))

service_count=$count

case $1 in
 enable)
  # Checked the PID file exists and check the actual status of process
  echo "Enabling gun services"
  count=0
  while [ $count -le $service_count ]; do
	sudo systemctl enable ${SERVICES[$count]}
	count=$((count + 1))
  done
 ;;
 disable)
  # Checked the PID file exists and check the actual status of process
  echo "Disabling gun services"
  count=0
  while [ $count -le $service_count ]; do
	sudo systemctl disable ${SERVICES[$count]}
	count=$((count + 1))
  done
 ;;
 start)
  # Checked the PID file exists and check the actual status of process
  echo "Starting gun services"
  count=0
  while [ $count -le $service_count ]; do
	sudo systemctl start ${SERVICES[$count]}
	echo ${SERVICES[$count]}" started"
	count=$((count + 1))

  done
 ;;
 stop)
  # Stop the SERVICEs.
  echo "Stoping gun services"
  count=0
  while [ $count -le $service_count ]; do
	sudo systemctl stop ${SERVICES[$count]}
	echo ${SERVICES[$count]}" stoped"
	count=$((count + 1))
  done
  ;;
 restart)
  # Restart the SERVICES.
  $0 stop && sleep 5 && $0 start
  ;;
 status)
  # Check the status of the process.
  count=0
  while [ $count -le $service_count ]; do
	systemctl status --no-pager ${SERVICES[$count]} | grep 'Active\|Loaded'
	echo ${SERVICES[$count]}
	count=$((count + 1))
  done
  ;;
 reload)
  echo NOP
  ;;
 *)
  # For invalid arguments, print the usage message.
  echo "Usage: $0 {enable|disable|start|stop|restart|reload|status}"
  exit 2
  ;;
esac
exit
