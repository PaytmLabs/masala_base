#
# Cookbook Name:: masala_base
# Recipe:: openssh
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

# Other recipes, like auth_sssd, will set some values
#node.default['openssh']['server']['']      = ''

include_recipe 'openssh'

# register process monitor
if node['masala_base']['dd_enable'] && !node['masala_base']['dd_api_key'].nil?
  ruby_block "datadog-process-monitor-sshd" do
    block do
      node.set['masala_base']['dd_proc_mon']['sshd'] = {
        search_string: ['sshd'],
        exact_match: true,
        thresholds: {
         warning: [1, 5],
         critical: [1, 10]
        }
      }
    end
    notifies :run, 'ruby_block[datadog-process-monitors-render]'
  end
end
