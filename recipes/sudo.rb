#
# Cookbook Name:: masala_base
# Recipe:: sudo
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

node.default['authorization']['sudo']['passwordless']      = true
node.default['authorization']['sudo']['include_sudoers_d'] = true
node.default['authorization']['sudo']['groups']            = ['wheel']
# Ensure vagrant sudo remains for kitchen work
if node['etc']['passwd']['vagrant']
  node.default['authorization']['sudo']['users']             = ['vagrant']
else
  node.default['authorization']['sudo']['users']             = []
end

include_recipe 'sudo'

