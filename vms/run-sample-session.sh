#!/bin/bash

set -x
set -e

. /vagrant/openrc

nova flavor-create micro 6 50 0 1 || true

quantum net-create net1
quantum subnet-create net1 10.0.33.0/24 --name=sub1

nova boot --flavor micro --image cirros-0.3.0-x86_64 vm1

quantum net-create ext-net --provider:network_type local --router:external true
quantum subnet-create ext-net 192.168.101.0/24 --enable_dhcp False

quantum router-create router1
quantum router-gateway-set router1 ext-net
quantum router-interface-add router1 sub1

FLOAT_ID=`quantum floatingip-create ext-net | grep ' id ' | awk '{print $4;}'`
VM1_ID=`nova list | grep vm1 | awk '{print $2;}'`
VM1_PORT_ID=`quantum port-list --fields id -- --device_id $VM1_ID | awk '{if (NR==4) print $2;}'`
quantum floatingip-associate $FLOAT_ID $VM1_PORT_ID
quantum floatingip-show $FLOAT_ID

echo "Give VM a minute to boot before trying ssh"
