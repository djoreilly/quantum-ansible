# OpenStack with Quantum Ansible installer for Vagrant
  
This repository contains a script that will automatically install OpenStack Grizzly with Quantum networking onto VirtualBox VMs using [Ansible](http://ansible.cc/) and Vagrant. It is a modification of [Lorin Hochstein's](https://github.com/lorin/openstack-ansible) for Folsom that used networking from Nova. The configuration is described in vms/Vagrantfile.


## Install prereqs

 * Ansible >= v1.1

            $ sudo pip install paramiko PyYAML Jinja2 ansible
      Or follow [(http://ansible.cc/docs/gettingstarted.html)](http://ansible.cc/docs/gettingstarted.html)
         
 * [Vagrant](http://vagrantup.com) (tested on 1.0.7)
 * VirtualBox (tested on 4.2.10-84104 on Ubuntu 12.10 Desktop)

## Get the Ubuntu 12.04 (precise) Vagrant box

Download the 64-bit Ubuntu Vagrant box:

	vagrant box add precise64 http://files.vagrantup.com/precise64.box

## Grab this repository

This repository uses a submodule that contains Lorin's custom Ansible modules for
OpenStack, so there's an extra command required after cloning the repo:


        git clone http://github.com/djoreilly/quantum-ansible
        git checkout grizzly
        cd openstack-ansible
        git submodule update --init


## Start the nodes and run the playbooks

    cd vms ; vagrant up ; cd ..
    ansible-playbook -v openstack.yaml

The controller has the Nova and Quantum CLIs.

    cd vms; vagrant ssh controller
    vagrant@controller:/vagrant$ ls
    openrc  run-sample-session.sh  Vagrantfile

    vagrant@controller:~$ source /vagrant/openrc
