#
# Cookbook Name::  drush
# Recipe:: default
#
# Author:: Mark Sonnabaum <mark.sonnabaum@acquia.com>
# Contributor:: Patrick Connolly <patrick@myplanetdigital.com>
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

install_path = node['drush']['install_path']

require_recipe "php"
require_recipe "git"

case node[:platform]
when "debian", "ubuntu", "arch"
  php_pear "Console_Table" do
    action :install
  end

  node['drush']['references'].each do |ref|
    git "#{install_path}-#{ref}" do
      repository "git://git.drupalcode.org/project/drush.git"
      reference ref
      action :sync
    end
  
    link "/usr/bin/drush-#{ref}" do
      to "#{install_path}-#{ref}/drush"
    end

    # master branch version needs to run once as root to avoid future errors.
    bash "Debug run of drush-#{ref}" do
      user "root"
      code "drush-#{ref} -q"
    end
  end

  link "/usr/bin/drush" do
    to "#{install_path}-#{node['drush']['references'].to_a[0]}/drush"
  end

  if node['drush']['bash_completion'] == "true"
    directory "/etc/bash_completion.d" do
      recursive true
    end

    link "/etc/bash_completion.d/drush.complete.sh" do
      to "#{install_path}-#{node['drush']['references'].to_a[0]}/drush.complete.sh"
      only_if "test -f #{install_path}-#{node['drush']['references'].to_a[0]}/drush.complete.sh"
    end
  else
    # Remove bash_complete if attribute "false"
    link "/etc/bash_completion.d/drush.complete.sh" do
      action :delete
      only_if "test -L /etc/bash_completion.d/drush.complete.sh"
    end
  end
end
