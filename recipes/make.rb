#
# Cookbook Name::  drush
# Recipe:: make
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

case node[:platform]
when "debian", "ubuntu", "arch"

  require_recipe "drush"

  git "/usr/share/drush_make" do
    repository "git://git.drupalcode.org/project/drush_make.git"
    reference "6.x-2.2"
    action :sync
  end

  link "/usr/bin/drush_make" do
    to "/usr/share/drush_make"
    not_if "test -f /usr/bin/drush_make/drush_make.drush.inc"
    only_if "test -f /usr/share/drush_make/drush_make.drush.inc"
  end

end
