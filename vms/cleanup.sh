#!/bin/bash

#set -x

echo "deleting vm1"
nova delete vm1
sleep 3


for i in $(quantum floatingip-list -c id -f csv --quote none | tr -d '\r' | tail -n+2);
do
    quantum floatingip-delete $i
done

quantum router-interface-delete router1 sub1
quantum router-gateway-clear router1
quantum router-delete router1


for i in $(quantum port-list -c id -f csv --quote none | tr -d '\r' | tail -n+2);
do
    quantum port-delete $i
done

quantum net-delete net1
quantum net-delete ext-net

quantum security-group-delete test-vms

echo "deleting key test-key"
nova keypair-delete test-key
