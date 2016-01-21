#
# Cookbook Name:: masala_base
# Recipe:: cloud
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

if node['masala_base']['img_build'] && node['masala_base']['img_type'] == 'ami'
  if (node['platform_family'] == 'rhel' && node['platform_version'].to_f < 7.0) || node['platform'] == 'debian'
    include_recipe 'masala_base::rootfs_resize_initrd'
  end
end
