# 
# Author:: Mark Sonnabaum <mark.sonnabaum@acquia.com>
# Contributor:: Patrick Connolly <patrick@myplanetdigital.com>
# Cookbook Name:: drush
# Recipe:: upgrade_pear
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

# Upgrade PEAR if current version is < 1.9.1
cur_version = `pear -V 2>&1 | head -1 | awk '{print $NF}' | tr -d '\n'`
php_pear "pear" do
  action :upgrade
  not_if { Gem::Version.new(cur_version) > Gem::Version.new('1.9.0') }
end
