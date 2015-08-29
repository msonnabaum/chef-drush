# Author:: Mark Sonnabaum <mark.sonnabaum@acquia.com>
# Contributor:: Patrick Connolly <patrick@myplanetdigital.com>
# Cookbook Name:: drush
# Recipe:: git
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

require_recipe "git"

case node[:platform]
when "debian", "ubuntu", "centos", "redhat"
  git node['drush']['install_dir'] do
    repository "https://github.com/drush-ops/drush.git"
    reference node['drush']['version']
    notifies :run, 'execute[install-drush-deps]', :immediately
    action :sync
  end

  link "/usr/bin/drush" do
    to "#{node['drush']['install_dir']}/drush"
  end
end

# We have to run composer against the directory if we using 6.x or above
require_recipe "composer"

execute 'install-drush-deps' do
  command "#{node['composer']['bin']} install --no-interaction --no-ansi --quiet --no-dev"
  cwd     node['drush']['install_dir']
  user    'root'
  group   'root'
  only_if { File.exists?(node['composer']['bin']) && File.exists?(node['drush']['install_dir'] + '/composer.json') }
  action  :nothing
end
