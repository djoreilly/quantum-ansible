# OpenStack with Quantum Ansible installer for Vagrant
  
This repository contains a script that will automatically install OpenStack Folsom with Quantum networking onto VirtualBox VMs using [Ansible](http://ansible.cc/) and Vagrant. It is a modification of [Lorin Hochstein's](https://github.com/lorin/openstack-ansible) that used networking from Nova. The configuration is described in vms/Vagrantfile and there is a diagram and more instructions [here](http://techbackground.blogspot.ie/2013/03/automated-openstack-folsom-with-quantum.html). 


## Install prereqs

 * Ansible >= v1.1 - at this time the version from pip is 1.0 and will not work (mysql lockout). So instead just get the latest:

            $ sudo pip install paramiko PyYAML Jinja2
            $ git clone git://github.com/ansible/ansible.git
            $ cd ./ansible
            $ sudo make install
      Or follow [(http://ansible.cc/docs/gettingstarted.html)](http://ansible.cc/docs/gettingstarted.html)
         
 * [Vagrant](http://vagrantup.com) (tested on 1.0.7)
 * VirtualBox (tested on 4.2.8r83876 on Ubuntu 12.10)

## Get the Ubuntu 12.04 (precise) Vagrant box

Download the 64-bit Ubuntu Vagrant box:

	vagrant box add precise64 http://files.vagrantup.com/precise64.box

## Grab this repository

This repository uses a submodule that contains Lorin's custom Ansible modules for
OpenStack, so there's an extra command required after cloning the repo:


        git clone http://github.com/djoreilly/quantum-ansible
        cd openstack-ansible
        git submodule update --init


## Bring up the cloud

    make all




If all goes well you should be able start the OpenStack dashboard on 

[http://10.0.10.10/horizon](http://10.0.10.10/horizon)

User: admin

Password: secrete
