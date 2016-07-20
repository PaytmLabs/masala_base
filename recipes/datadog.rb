#
# Cookbook Name:: masala_base
# Recipe:: datadog
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

require 'uri'

if node['masala_base']['dd_enable'] and not node['masala_base']['dd_api_key'].nil?
  node.set['datadog']['api_key'] = node['masala_base']['dd_api_key']
  node.set['datadog']['application_key'] = node['masala_base']['dd_app_key']
  # pass the "5 tags", provided or forced by the provisioner, plus optional
  tags = [
      "environment:#{node['masala_base']['machine_tags']['environment']}",
      "application:#{node['masala_base']['machine_tags']['application']}",
      "cluster:#{node['masala_base']['machine_tags']['cluster']}",
      "role:#{node['masala_base']['machine_tags']['role']}",
      "owner:#{node['masala_base']['machine_tags']['owner']}",
      "dc:#{node['masala_base']['machine_tags']['dc']}"
  ]
  tags.concat( node['masala_base']['dd_extra_tags'] )
  node.set['datadog']['tags'] = tags.join(", ")

  if Chef::Config.has_key?(:http_proxy)
    proxy = URI(Chef::Config[:http_proxy])
    node.default['datadog']['web_proxy']['host'] = proxy.hostname
    node.default['datadog']['web_proxy']['port'] = proxy.port
    if Chef::Config.has_key?(:http_proxy_user)
      node.default['datadog']['web_proxy']['user'] = Chef::Config[:http_proxy_user]
    end
    if Chef::Config.has_key?(:http_proxy_user)
      node.default['datadog']['web_proxy']['password'] = Chef::Config[:http_proxy_pass]
    end
  end

  include_recipe 'datadog::dd-agent'
  if node['masala_base']['dd_handler_enable']
    include_recipe 'datadog::dd-handler'
  end

  # setup deferred action for process monitoring
  ruby_block "datadog-process-monitors-render" do
    block do
      if not node['masala_base']['dd_proc_mon'].empty?
        inst = []
        node['masala_base']['dd_proc_mon'].each do |name, cfg|
          mon = {}.deep_merge(cfg)
          mon['name'] = name
          inst << mon
        end
        node.set['datadog']['process']['instances'] = inst
        dd_proc = Chef::Resource::DatadogMonitor.new('process', run_context)
        dd_proc.instances = node['datadog']['process']['instances']
        dd_proc.run_action(:add)
      end
    end
    action :nothing
  end

end

