# OpenStack Havana with Neutron installer
  
This repository contains a script that will automatically install OpenStack Havana with Neutron networking (ML2 plugin with linuxbridge agents) onto VirtualBox VMs using [Ansible](http://ansible.cc/) and Vagrant. It is a modification of [Lorin Hochstein's](https://github.com/lorin/openstack-ansible) for Folsom that used networking from Nova. The configuration is described in vms/Vagrantfile.


## Install prereqs

 * About 3GB of free RAM
 * git
 * Ansible (tested with v1.2)

            $ sudo pip install paramiko PyYAML Jinja2 ansible
      Or follow [(http://ansible.cc/docs/gettingstarted.html)](http://ansible.cc/docs/gettingstarted.html)
         
 * [Vagrant](http://vagrantup.com) (tested with 1.2.3)
 * VirtualBox (tested with 4.2.10-84104 on Ubuntu 13.04 Desktop)

## Get the 64-bit Ubuntu 12.04 (precise) Vagrant box

	vagrant box add precise64 http://files.vagrantup.com/precise64.box

## Grab this repository and run the installer

        git clone http://github.com/djoreilly/quantum-ansible
        cd quantum-ansible
        git checkout havana-ml2-lb
        ./install-openstack

It takes about 20 minutes, and the dashboard should be available at [(http://10.0.10.10/horizon)](http://10.0.10.10/horizon) with user=admin and password=secrete.

Also the controller has the Nova, Neutron and Cinder CLIs.

    cd vms; vagrant ssh controller

    vagrant@controller:~$ ls /vagrant 
    admin.openrc  cleanup.sh  openrc  run-sample-session.sh  Vagrantfile

    vagrant@controller:~$ source /vagrant/openrc
    vagrant@controller:~$ nova list
    vagrant@controller:~$ neutron net-list

The run-sample-session.sh shows how to create the external network with provider type flat.
