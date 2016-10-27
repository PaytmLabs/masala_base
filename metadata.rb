name             'masala_base'
maintainer       'Joe Hohertz'
maintainer_email 'jhohertz@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures masala_base'
long_description 'Installs/Configures masala_base'
version          '0.1.0'

depends          'yum-epel', '>= 0.0.0'
depends          'sysctl', '~> 0.7.5'
depends          'ixgbevf', '~> 0.1.0'
depends          'system', '~> 0.11.0'
#depends          'locale', '~> 1.0.2'
depends          'ntp', '~> 2.0.0'
depends          'rsyslog', '~> 4.0.0'
depends          'logrotate', '~> 1.9.2'
depends          'sudo', '~> 2.9.0'
depends          'masala_ldap', '~> 0.1.0'
depends          'java', '~> 1.39.0'
depends          'openssh', '~> 2.0.0'
depends          'poise-python', '~> 1.3.0'
depends          'datadog', '~> 2.4.0'
depends          'iptables', '~> 2.2.0'
depends          'ulimit',  '~> 0.4.0'
depends          'magic', '~> 1.5.0'
depends          'users', '~> 4.0.1'
