#
# Author:: Konstantin Sorokin <k.n.sorokin@gmail.com>
# Cookbook Name:: drush
# Provider:: execute
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

require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

# the logic in all action methods mirror that of
# the Chef::Provider::Package which will make
# refactoring into core chef easy

def whyrun_supported?
  true
end

action :run do
    command = ""
    if @new_resource.cwd
        command << "cd #{@new_resource.cwd} && "
    end
    command << "drush #{@new_resource.command}"
    if @new_resource.options and !new_resource.options.empty?
        @new_resource.options.each do |option, value|
            command << " #{option}"
            command << "#{value}" if value and !value.empty?
        end
    end

    # Drush force yes option
    command << " --yes"

    Chef::Log.info(command)
    shell_out!(command)
end
