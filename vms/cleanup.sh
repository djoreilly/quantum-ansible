#!/bin/bash

#set -x

echo "deleting vm1"
nova delete vm1
sleep 3


for i in $(neutron floatingip-list -c id -f csv --quote none | tr -d '\r' | tail -n+2);
do
    neutron floatingip-delete $i
done

neutron router-interface-delete router1 sub1
neutron router-gateway-clear router1
neutron router-delete router1


for i in $(neutron port-list -c id -f csv --quote none | tr -d '\r' | tail -n+2);
do
    neutron port-delete $i
done

neutron net-delete net1
neutron net-delete ext-net

neutron security-group-delete test-vms

echo "deleting key test-key"
nova keypair-delete test-key
