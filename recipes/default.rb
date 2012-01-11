# 
# Author:: Mark Sonnabaum <mark.sonnabaum@acquia.com>
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

# Upgrade PEAR if current version is < 1.9.1
php_pear "pear" do
  cur_version = `pear -V| head -1| awk -F': ' '{print $2}'`
  action :upgrade
  not_if { Gem::Version.new(cur_version) > Gem::Version.new('1.9.0') }
end

# Initialize drush PEAR channel
dc = php_pear_channel "pear.drush.org" do
  action :discover
end

# Install drush
php_pear "drush" do
  version node[:drush][:version]
  channel dc.channel_name
  action :install
end

# Install Console_Table
php_pear "Console_Table" do
  action :install
end
