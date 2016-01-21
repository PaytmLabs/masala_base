#
# Cookbook Name:: masala_base
# Recipe:: motd
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

# Also deal with prelogin issue in motd recipe
file 'issue file' do
  path '/etc/issue.net'
  content node['masala_base']['issue_text']
  owner 'root'
  group node['root_group']
  mode '0644'
  action :create
end

bash 'update-motd' do
  user 'root'
  code value_for_platform( 
    # Maybe 8.1 simplified this? not looking back for now
    #'debian' => { 'default' => 'uname -snrvm > /var/run/motd && cat /etc/motd.tail >> /var/run/motd' },
    'ubuntu' => { 'default' => 'run-parts --lsbsysinit /etc/update-motd.d > /run/motd.dynamic' },
    'default' => 'echo'
  )
  action :nothing
end

cookbook_file '/etc/update-motd.d/50-masala' do
  source 'motd-inject-ubuntu.sh'
  owner 'root'
  group node['root_group']
  mode '0755'
  action :create
  only_if { node['platform'] == 'ubuntu' }
end

template value_for_platform( 'default' => '/etc/motd', 'ubuntu' => { 'default' => '/etc/motd.tail' }  ) do
  source 'motd.erb'
  owner 'root'
  group node['root_group']
  mode '0644'
  action :create
  notifies :run, 'bash[update-motd]'
end


