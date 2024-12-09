#!/bin/bash

count=0	

#regidster input service
while [ $count -le 6 ]; do
	index=$((count + 1))
	SERVICES[$count]=fa_osd_input_${index}.service
	echo ${SERVICES[$count]}
	count=$((count + 1))
done

#register osd manager
SERVICES[$count]=fa_osd_manager.service

count=$((count + 1))

#register amqp2tcp
SERVICES[$count]=fa_osd_amqp2tcp.service

count=$((count + 1))

#register shutdowner
SERVICES[$count]=fa_osd_shutdowner.service

count=$((count + 1))

service_count=$count
	
echo $service_count

case $1 in
 enable)
  # Checked the PID file exists and check the actual status of process
  echo "Enabling osd services"
  count=0
  while [ $count -le $service_count ]; do
	sudo systemctl enable ${SERVICES[$count]}
	count=$((count + 1))
  done
 ;;
 disable)
  # Checked the PID file exists and check the actual status of process
  echo "Disabling osd services"
  count=0
  while [ $count -le $service_count ]; do
	sudo systemctl disable ${SERVICES[$count]}
	count=$((count + 1))
  done
 ;;
 start)
  # Checked the PID file exists and check the actual status of process
  echo "Starting osd services"
  count=0
  while [ $count -le $service_count ]; do
	sudo systemctl start ${SERVICES[$count]}
	echo ${SERVICES[$count]}" started"
	count=$((count + 1))

  done
 ;;
 stop)
  # Stop the SERVICEs.
  echo "Stoping osd services"
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
