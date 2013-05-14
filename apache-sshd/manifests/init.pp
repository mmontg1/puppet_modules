# Class: apache-sshd
#
# This class both installs Apache, and configures sshd
# Not going to re-invent the wheel here, so I'm using
# an already existing puppetlabs/apache module, but 
# I'm using my own sshd module as I'd like a bit more 
# control over the sshd configuration.
#
# - Michael Montgomery <mmontg1@mindspring.com>
#
# Tested platforms:
#   - Ubuntu 10.04, 12.04
#   - Redhat Enterprise 5, 6
#
# Parameters:
#
# Actions:
#   - Install Apache
#   - Ensures sshd is installed, and disables root login
#
# Requires:
#   - puppetlabs/apache
#   - mmontg1/sshd
#
# Sample Usage:
#
class apache-sshd (
) {

  class { 'apache':
  }
    
  class { 'sshd':
    root_login => 'no'
  }

}
