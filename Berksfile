source "https://supermarket.chef.io"

cookbook 'ixgbevf', :git => 'https://github.com/PaytmLabs/chef-ixgbevf.git', :ref => 'master'
cookbook 'system', :git => 'https://github.com/PaytmLabs/chef-system.git', :ref => 'feature-fix-debian-tz'

# Due to a terrible design decision in berkshelf to not recursively resolve dependencies, we must declare all dependencies of our dependencies

# Dependencies of masala_ldap:
cookbook 'openldap', :git => 'https://github.com/PaytmLabs/chef-openldap.git', :ref => 'feature-our-fixes'
cookbook 'sssd_ldap', :git => 'https://github.com/PaytmLabs/chef-sssd_ldap.git', :ref => 'feature-restart-control'
cookbook 'masala_ldap', :git => 'https://github.com/PaytmLabs/masala_ldap.git', :ref => 'develop'

metadata
