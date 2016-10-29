
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

default['masala_base']['users_databag'] = 'users'
default['masala_base']['groups_databag'] = 'groups'
default['masala_base']['sudoers_databag'] = 'sudoers'
default['masala_base']['deploy_groups'] = []
default['masala_base']['deploy_sudoers'] = []

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

# Tell poise python to use system packages
override['poise-python']['provider'] = 'system'
override['poise-python']['options']['pip_version'] = '7.1.2'

# New local defaults for included cookbooks
default['system']['upgrade_packages_at_compile'] = false
default['system']['delay_network_restart'] = false
default['openssh']['server']['banner'] = '/etc/issue.net'
default['openssh']['server']['subsystem'] = 'sftp internal-sftp'
default['openssh']['server']['protocol'] = '2'
default['openssh']['server']['use_dns'] = 'no'
default['openssh']['server']['syslog_facility'] = 'AUTHPRIV'
default['openssh']['server']['gssapi_authentication'] = 'yes'
default['openssh']['server']['gssapi_clean_up_credentials'] = 'yes'
default['openssh']['server']['accept_env'] = 'LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT LC_IDENTIFICATION LC_ALL LANGUAGE XMODIFIERS'

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

