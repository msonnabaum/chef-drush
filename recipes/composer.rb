# Author:: Mark Sonnabaum <mark.sonnabaum@acquia.com>
# Contributor:: Klaas Van Waesberghe <klaasvw@gmail.com>
# Cookbook Name:: drush
# Recipe:: composer
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

require_recipe "composer"

case node[:platform]
when "debian", "ubuntu", "centos", "redhat"
  execute "install_drush_composer" do
    command "#{node['composer']['bin']} global require --no-interaction drush/drush:#{node['drush']['version']}"
    not_if "which drush"
  end

  link "/usr/local/bin/drush" do
    to "#{Dir.home(user)}/.composer/vendor/bin/drush"
  end
end
