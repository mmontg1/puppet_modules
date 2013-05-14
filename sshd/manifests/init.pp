# Class: sshd
#
# This module manages installing, configuring
# and managing the sshd daemon
#
# - Michael Montgomery <mmontg1@mindspring.com>
#
# Tested platforms:
#   - Ubuntu 10.04, 12.04
#   - Redhat Enterprise 5, 6
#
# Parameters:
#   - ensure  
#   -- do we want the daemon stopped or started?
#   - autoupdate 
#   -- allows for autoupdating of sshd package
#   - root_login
#   -- enables or disables root login
#
# Actions:
#
#   - Installs, configures, and manages sshd
#
# Requires:
#
class sshd(
  $ensure='running',
  $autoupdate=true,
  $root_login=yes,        
) {

  if ! ($ensure in [ 'running', 'stopped' ]) {
    fail('ensure parameter must be running or stopped')
  }

  # Check ENC for overrides...
  if ($::root_login == 'yes') {
    $root_login_real=yes
  } else {
    $root_login_real=$root_login
  }

  if $autoupdate == true {
    $package_ensure = latest
  } elsif $autoupdate == false {
    $package_ensure = present
  } else {
    fail('autoupdate parameter must be true or false')
  }

  include sshd::params

  package { 'openssh-server':
    ensure => $package_ensure,
    name   => $sshd::params::pkg_name,
  }

  file { $sshd::params::config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template("${module_name}/${sshd::params::sshd_config}"),
    require => Package[$sshd::params::pkg_name],
  }

  file { $sshd::params::system_config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template("${module_name}/ssh.erb"),
    require => Package[$sshd::params::pkg_name],
  }

  service { $sshd::params::service_name:
    ensure     => 'running',
    hasstatus  => true,
    hasrestart => true,
    subscribe  => File["$sshd::params::config"]
  }
}
