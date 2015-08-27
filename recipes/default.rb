# 
# Author:: Mark Sonnabaum <mark.sonnabaum@acquia.com>
# Author:: Patrick Connolly <patrick@myplanetdigital.com>
# Cookbook Name:: drush
# Recipe:: default
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
#

include_recipe "php"

if node['drush']['version'].split('.').first.to_i >= 7 and node['drush']['install_method'] == 'pear'
  Chef::Application.fatal('Drush versions above 7.0 are no longer available via PEAR. Use "github" or "git" install method to get those installed')
end

# Upgrade PEAR if current version is < 1.9.1
include_recipe "drush::upgrade_pear" if node['drush']['install_method'] == "pear"

# Install Console_Table only if drush version is < 6.x, since
# 6.x and above uses Composer to install requirements
if node['drush']['version'].split('.').first.to_i < 6
  include_recipe "drush::install_console_table"
end

include_recipe "drush::#{node['drush']['install_method']}"
