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

include_recipe "git"

case node[:platform]
when "debian", "ubuntu", "centos", "redhat"
  git node['drush']['install_dir'] do
    repository "https://github.com/drush-ops/drush.git"
    reference node['drush']['version']
    action :sync
  end

  link "/usr/bin/drush" do
    to "#{node['drush']['install_dir']}/drush"
  end

  if node['drush']['version'] == 'master' || Gem::Dependency.new('', '~> 7').match?('', node['drush']['version'])
    include_recipe "composer"
    execute "drush-composer-install" do
      cwd node['drush']['install_dir']
      command "#{node['composer']['bin']} install --no-interaction --no-ansi --quiet --no-dev"
      action :nothing
      subscribes :run, "git[#{node['drush']['install_dir']}]"
    end
  end
end
