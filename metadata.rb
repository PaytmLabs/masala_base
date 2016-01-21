name             'masala_base'
maintainer       'Joe Hohertz'
maintainer_email 'jhohertz@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures masala_base'
long_description 'Installs/Configures masala_base'
version          '0.1.0'

depends          'yum-epel', '>= 0.0.0'
depends          'sysctl', '~> 0.6.2'
depends          'ixgbevf', '~> 0.1.0'
depends          'system', '~> 0.10.1'
#depends          'locale', '~> 1.0.2'
depends          'ntp', '~> 1.9.0'
depends          'rsyslog', '~> 2.1.0'
depends          'logrotate', '~> 1.9.2'
depends          'sudo', '~> 2.7.2'
depends          'masala_ldap', '~> 0.1.0'
depends          'java', '~> 1.35.0'
depends          'openssh', '~> 1.5.2'
depends          'poise-python', '~> 1.2.1'
depends          'datadog', '~> 2.2.0'
depends          'iptables', '~> 1.1.0'
depends          'ulimit',  '~> 0.3.3'
