#
# Cookbook Name:: masala_base
# Recipe:: local_users
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

group node['masala_base']['admin']['group']

user node['masala_base']['admin']['user'] do
  action :create
  gid node['masala_base']['admin']['group']
  system false
  shell '/bin/bash'
  home "/home/#{node['masala_base']['admin']['user']}"
  manage_home true
end

directory "/home/#{node['masala_base']['admin']['user']}/.ssh" do
  action :create
  recursive false
  mode '0700'
  owner node['masala_base']['admin']['user']
  group node['masala_base']['admin']['group']
end

group 'wheel' do
  append true
  members [node['masala_base']['admin']['user']]
end

file "/home/#{node['masala_base']['admin']['user']}/.ssh/authorized_keys" do
  content node['masala_base']['admin']['ssh_pubkey']
  mode '0600'
  owner node['masala_base']['admin']['user']
  group node['masala_base']['admin']['group']
end

# see attributes/default.rb
include_recipe 'ulimit'

