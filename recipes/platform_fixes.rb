#
# Cookbook Name:: masala_base
# Recipe:: platform_fixes
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

# enable cloud-init disk_setup module on centos
if node['platform_family'] == 'rhel'
  ruby_block "cloud-init-disk-setup-enable-centos" do
    block do
      fe = Chef::Util::FileEdit.new("/etc/cloud/cloud.cfg")
      fe.insert_line_after_match(/^cloud_config_modules:/, " - disk_setup")
      fe.write_file
    end
    only_if { ::File.exist? "/etc/cloud/cloud.cfg" }
  end
end
if node['platform'] == 'debian'
  ruby_block "cloud-init-disk-setup-enable-debian" do
    block do
      fe = Chef::Util::FileEdit.new("/etc/cloud/cloud.cfg")
      fe.insert_line_after_match(/^ - emit_upstart/, " - disk_setup")
      fe.write_file
    end
    only_if { ::File.exist? "/etc/cloud/cloud.cfg" }
  end
end

# Ensure centos will enable secondary network interface if configured
if node['system'].has_key?('secondary_interface') and node['network']['interfaces'].has_key?(node['system']['secondary_interface'])
  if node['platform_family'] == "rhel"
    if node['platform_version'].to_f < 7.0
      ruby_block "lock-gateway-interface" do
        block do
          fe = Chef::Util::FileEdit.new("/etc/sysconfig/network")
          fe.insert_line_if_no_match(/^GATEWAYDEV=/, "GATEWAYDEV=#{node['system']['gateway_interface']}")
          fe.write_file
        end
      end
      template "/etc/sysconfig/network-scripts/ifcfg-#{node['system']['secondary_interface']}" do
        source 'ifcfg.erb'
        mode '0644'
        owner 'root'
        group node['root_group']
      end
    end
  end
end

