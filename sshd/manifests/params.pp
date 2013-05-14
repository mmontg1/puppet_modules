# Class: sshd::params
#
# This class manages sshd parameters
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class sshd::params {

  case $::operatingsystem {
    debian, ubuntu: {

      $supported     = true
      $config        = '/etc/ssh/sshd_config'
      $sshd_config   = 'sshd_config.debian.erb'
      $system_config = '/etc/default/ssh'
      $pkg_name      = [ 'openssh-server' ]
      $service_name  = 'ssh'

    }
    centos, redhat, oel, linux, fedora, Amazon: {

      $supported     = true
      $config        = '/etc/ssh/sshd_config'
      $system_config = '/etc/sysconfig/sshd'
      $pkg_name      = [ 'openssh-server' ]
      $service_name  = 'sshd'

      case $::operatingsystemrelease {
        /^3/: {
          $sshd_config = 'sshd_config.rhel3.erb'
        }
        /^5/: {
          $sshd_config = 'sshd_config.rhel5-6.erb'
        }
        /^6/: {
          $sshd_config = 'sshd_config.rhel5-6.erb'
        }
      }

    }
    freebsd: {
      $supported = false
      notify { "${module_name}_unsupported":
        message => "The ${module_name} module is not supported on ${::operatingsystem}",
      }
    }
    default: {
      $supported = false
      notify { "${module_name}_unsupported":
        message => "The ${module_name} module is not supported on ${::operatingsystem}",
      }
    }
  }

}
