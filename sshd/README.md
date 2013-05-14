# Puppet module: sshd

This is a Puppet module for Sshd that manages installation, and configuration

* Note that this module allows overriding of the class parameter via ENC (Puppet Dashboard/Foreman/etc)

Made by Michael Montgomery <mmontg1@mindspring.com>

Official git repository: http://github.com/mmontg1/puppet_modules

## USAGE - Basic management

* Install sshd with default settings

        class { 'sshd': }

* Disable root login

        class { 'sshd':
          root_login => 'no',
        }

* Remove sshd service.

        class { 'sshd':
          ensure => 'absent',
        }

* Disable autoupdating

        class { 'sshd':
          autoupdate => 'false',
        }

* Control root login via ENC with Parameter (For Puppet Dashboard/Foreman/etc)
	
	root_login: "yes"
