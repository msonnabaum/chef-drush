# 
# Author:: David King <dking@xforty.com>
# Contributor:: Patrick Connolly <patrick@myplanetdigital.com>
# Cookbook Name:: drush
# Attributes:: default
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

# Pear search does not currently work with the preferred state. So we have to
# specify a default version for now.  https://pear.php.net/bugs/bug.php?id=19138
# TODO: implement preferred_state attribute and logic once pear bug is fixed

# Options: pear, git
default['drush']['install_method'] = "pear"

# Used for drush install via git and make install (PEAR stores here by default).
default['drush']['install_dir'] = "/usr/share/php/drush"

# When installing via PEAR, this is the x.y.z pear version (eg. 4.5.0)
# When installing via Git, this is a commit/tag/branch reference (eg. 6e4c1e22f0b / 7.x-4.5 / 7.x-4.x)
default['drush']['version'] = "5.0.0"
default['drush']['make']['version'] = "2.3"
