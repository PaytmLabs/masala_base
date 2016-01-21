#
# Cookbook Name:: masala_base
# Recipe:: rootfs_resize_initrd
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

if node['platform_family'] == 'rhel' && node['platform_version'].to_f < 7.0
  include_recipe 'yum-epel'
  package 'cloud-utils-growpart'
end

package 'cloud-utils'
package 'parted'

cookbook_file '/usr/src/rootfs-resize.tgz' do
  source 'rootfs-resize.tgz'
  owner 'root'
  group node['root_group']
  mode '0644'
  action :create
end

directory '/usr/src/rootfs-resize' do
  owner 'root'
  group node['root_group']
  mode 0755
end

ruby_block "disable-cloud-init-resize" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/cloud/cloud.cfg")
    fe.search_file_delete_line(/^\s+- growpart\s*$/)
    fe.search_file_delete_line(/^\s+- resizefs\s*$/)
    fe.write_file
  end
  action :nothing
end

execute "install-resize-tools" do
  cwd "/usr/src/rootfs-resize"
  command "./install"
  action :nothing
  notifies :run, 'ruby_block[disable-cloud-init-resize]'
end

execute "untar-resize-tools" do
  cwd "/usr/src/rootfs-resize"
  command "tar zxf /usr/src/rootfs-resize.tgz"
  not_if do
    File.exist? "/usr/src/rootfs-resize/install"
  end
  notifies :run, 'execute[install-resize-tools]'
end

