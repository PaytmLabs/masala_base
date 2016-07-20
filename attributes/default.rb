
# flag if we are building an image or not
default['masala_base']['img_build'] = false

# Java is the norm, but for some things, not needed, allow to disable
default['masala_base']['install_jdk'] = true

# Which interface is default gateway
default['masala_base']['gateway_interface'] = 'eth0'

# Needed for AWS enhanced networking
default['masala_base']['upgrade_ixgbevf'] = true

# Enablle sssd_ldap
default['masala_base']['enable_auth_sssd'] = false

default['masala_base']['admin']['user'] = 'masala'
default['masala_base']['admin']['group'] = 'masala'
# default is the vagrant insecure key
default['masala_base']['admin']['ssh_pubkey'] = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1/ojMRu9tNsIcKkB7vacgZMUNoT3EvoYrW4vXjmSZgkOJSl+IlFyw3WzOeSi4ZbbjZEDAQT3b3rcyD+HkZnsr0olujdZ7YydZu8vX1hTDLFwTPZG88vrASMHZM5RlKneoZq+hAwoy3AXvkz9kdKWZYzYjjrlLZmhcGbbKn1HoScekKj6IIr88e+gwKpJagLsF6EYRos5w70tDJamQHhtoR6lFFmVOucW9Esa5DDX9dI34Bq5P8mkm9Toyrt9EupZPPZPyJt/G/pcO7WnJsIzKEGT9DRlK6MSyaYwrA8+jyNj3iCXrhGAzZYkRUBOpnk7vgraMl97010JvU9CpWP6f vagrant'

adm_user = node["masala_base"]["admin"]["user"]
default["ulimit"]["users"][adm_user]["filehandle_limit"] = 100000
default["ulimit"]["users"][adm_user]["process_limit"] = 32768
default["ulimit"]["users"][adm_user]["memory_limit"] = "unlimited"
# FIXME: needs support for as upstream:  user - as unlimited

default['masala_base']['dd_enable'] = false
default['masala_base']['dd_api_key'] = nil
default['masala_base']['dd_handler_enable'] = false
default['masala_base']['dd_app_key'] = nil
# array of optional data dog tags to add to primary ones
default['masala_base']['dd_extra_tags'] = []
default['masala_base']['dd_proc_mon'] = {}

# These are meant to be injected from the provisioner
# Defaults are at best ok for basic testing of the base
default['masala_base']['machine_tags']['environment'] = 'no_name'
default['masala_base']['machine_tags']['application'] = 'no_name'
default['masala_base']['machine_tags']['cluster'] = 'no_name'
default['masala_base']['machine_tags']['role'] = 'not_defined'
default['masala_base']['machine_tags']['owner'] = 'no_one'
default['masala_base']['machine_tags']['dc'] = 'not_defined'

# A hash of optional extra sudo rules to install
default['masala_base']['sudo.d'] = {}

# Tell poise python to use system packages
override['poise-python']['provider'] = 'system'
override['poise-python']['options']['pip_version'] = '7.1.2'

# New local defaults for included cookbooks
default['system']['upgrade_packages_at_compile'] = false
default['system']['delay_network_restart'] = false
default['openssh']['server']['banner'] = '/etc/issue.net'

default['masala_base']['issue_text'] = <<EOF

::::    ::::      :::      ::::::::      :::     :::            :::     
+:+:+: :+:+:+   :+: :+:   :+:    :+:   :+: :+:   :+:          :+: :+:   
+:+ +:+:+ +:+  +:+   +:+  +:+         +:+   +:+  +:+         +:+   +:+  
+#+  +:+  +#+ +#++:++#++: +#++:++#++ +#++:++#++: +#+        +#++:++#++: 
+#+       +#+ +#+     +#+        +#+ +#+     +#+ +#+        +#+     +#+ 
#+#       #+# #+#     #+# #+#    #+# #+#     #+# #+#        #+#     #+# 
###       ### ###     ###  ########  ###     ### ########## ###     ### 

EOF

# sysctl -w net.ipv4.tcp_mtu_probing=1
default['sysctl']['params']['net']['ipv4']['tcp_mtu_probing'] = "1"

# set fqdn for datadog
default['datadog']['hostname'] = node['system']['short_hostname'] + '.' + node['system']['domain_name']

