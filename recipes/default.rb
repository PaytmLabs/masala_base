#
# Cookbook Name:: masala_base
# Recipe:: default
#
# Copyright 2016, Paytm Labs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Setup proxy for yum if needed, apt will follow env vars setup by chef
if Chef::Config.has_key?(:http_proxy)
  node.default['yum']['main']['proxy'] = Chef::Config[:http_proxy]

  if Chef::Config.has_key?(:http_proxy_user)
    node.default['yum']['main']['proxy_username'] = Chef::Config[:http_proxy_user]
  end

  if Chef::Config.has_key?(:http_proxy_pass)
    node.default['yum']['main']['proxy_password'] = Chef::Config[:http_proxy_pass]
  end
end

node.override['apt']['compile_time_update'] = true

include_recipe 'ixgbevf' if node['masala_base']['upgrade_ixgbevf']
include_recipe 'sysctl::apply'
include_recipe 'system::update_package_list'
include_recipe 'system::timezone'
include_recipe 'system::hostname' if not node['masala_base']['img_build']
#include_recipe 'locale'
include_recipe 'system::upgrade_packages'
include_recipe 'masala_base::install_packages'
include_recipe 'masala_base::platform_fixes'
include_recipe 'ntp'
include_recipe 'masala_ldap::auth_sssd' if node['masala_base']['enable_sssd_ldap']
include_recipe 'rsyslog'
include_recipe 'logrotate'
include_recipe 'masala_base::sudo'
include_recipe 'masala_base::admin_user'
include_recipe 'masala_base::openssh'
include_recipe 'java' if node['masala_base']['install_jdk']

include_recipe 'poise-python'
python_package 'awscli'

include_recipe 'masala_base::datadog'
include_recipe 'masala_base::motd'
include_recipe 'masala_base::cloud'

# FIXME: This is not nice, but presently needed until there is a managed story
service 'iptables' do
  action   [:disable, :stop]
end

