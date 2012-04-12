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

# Drush PEAR channel requires > 1.9.0 due to hosting
# on GitHub, where PEAR repo uses CNAME record.

original_pear_version = nil

ruby_block "check_pear_version" do
  block do
    original_pear_version = %x[ pear -V 2>&1 ].match(/PEAR.*(\d+\.\d+\.\d+)/)[1]
    original_pear_version = Gem::Version.create(original_pear_version)
  end
end

declared_pear_version = Gem::Version.create("1.9.4")

php_pear "PEAR" do
  version declared_pear_version.to_s
  options "--force"
  action :install
  only_if { original_pear_version != declared_pear_version }
end
