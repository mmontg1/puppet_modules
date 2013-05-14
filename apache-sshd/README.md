# Puppet module: apache-sshd

This is a Puppet module for both apache and sshd that manages installation, and configuration

Made by Michael Montgomery <mmontg1@mindspring.com>

Official git repository: http://github.com/mmontg1/puppet_modules

## USAGE - Basic management

* Install sshd with default settings

        class { 'apache-sshd': }

## Requires

* Since I didn't want to re-invent the wheel, it requires

        puppetlabs/apache
        
* Also requires personal module

        mmontg1/sshd
