#!/bin/bash

set -x
set -e

. /vagrant/openrc

nova flavor-create micro 6 50 0 1 || true

chmod 0600 /vagrant/test-key
nova keypair-add --pub-key /vagrant/test-key.pub test-key

quantum net-create net1
quantum subnet-create net1 10.0.33.0/24 --name=sub1

quantum net-create ext-net --provider:network_type local --router:external true
quantum subnet-create ext-net 192.168.101.0/24 --enable_dhcp False

quantum router-create router1
quantum router-gateway-set router1 ext-net
quantum router-interface-add router1 sub1

TEST_SG=test-vms
quantum security-group-create $TEST_SG
quantum security-group-rule-create --protocol icmp --direction ingress $TEST_SG
quantum security-group-rule-create --protocol tcp --port-range-min 22 \
	--port-range-max 22 --direction ingress $TEST_SG


PORT_ID=$(quantum port-create --security-group $TEST_SG net1 \
          -f shell --variable id | grep '^id=' | cut -d= -f2 | tr -d '"')

sleep 5 # TODO find out why dhcp replies are dropped w/o this delay

nova boot --flavor micro --image cirros-0.3.0-x86_64 --nic port-id=$PORT_ID \
          --key-name test-key vm1


FLOAT_ID=`quantum floatingip-create ext-net | grep ' id ' | awk '{print $4;}'`
VM_ID=`nova list | grep vm1 | awk '{print $2;}'`

quantum floatingip-associate $FLOAT_ID $PORT_ID
quantum floatingip-show $FLOAT_ID

eval `quantum floatingip-show -f shell --variable floating_ip_address $FLOAT_ID`
echo "Give VM a minute to boot before trying ssh -i vms/test-key cirros@${floating_ip_address} from main host"
