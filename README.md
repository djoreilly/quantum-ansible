# OpenStack Grizzly with Quantum Ansible installer for Vagrant
  
This repository contains a script that will automatically install OpenStack Grizzly with Quantum networking onto VirtualBox VMs using [Ansible](http://ansible.cc/) and Vagrant. It is a modification of [Lorin Hochstein's](https://github.com/lorin/openstack-ansible) for Folsom that used networking from Nova. The configuration is described in vms/Vagrantfile and there is a diagram [here] (http://techbackground.blogspot.ie/2013/04/openstack-grizzly-with-quantum-multi.html)


## Install prereqs

 * About 3GB of free RAM
 * git
 * Ansible >= v1.1

            $ sudo pip install paramiko PyYAML Jinja2 ansible
      Or follow [(http://ansible.cc/docs/gettingstarted.html)](http://ansible.cc/docs/gettingstarted.html)
         
 * [Vagrant](http://vagrantup.com) (tested on 1.0.7)
 * VirtualBox (tested on 4.2.10-84104 on Ubuntu 12.10 Desktop)

## Get the 64-bit Ubuntu 12.04 (precise) Vagrant box

	vagrant box add precise64 http://files.vagrantup.com/precise64.box

## Grab this repository and run the installer

        git clone http://github.com/djoreilly/quantum-ansible
        cd quantum-ansible
        ./install-openstack

It takes about 15 minutes and the dashboard should be available at [(http://10.0.10.10/horizon)](http://10.0.10.10/horizon)
Also the controller has the Nova, Quantum and Cinder CLIs.

    cd vms; vagrant ssh controller

    vagrant@controller:~$ ls /vagrant 
    admin.openrc  cleanup.sh  openrc  run-sample-session.sh  Vagrantfile

    vagrant@controller:~$ source /vagrant/openrc
    vagrant@controller:~$ nova list
