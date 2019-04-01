#
# Cookbook Name:: fb_tmpwatch
# Recipe:: default
#
# Copyright (c) 2016-present, Facebook, Inc.
# All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'fb_tmpclean::packages'

case node['platform_family']
when 'rhel', 'fedora'
  config = '/etc/cron.daily/tmpwatch'
  config_src = 'tmpwatch.erb'
when 'debian'
  config = '/etc/cron.daily/tmpreaper'
  config_src = 'tmpreaper.erb'
when 'mac_os_x'
  config = '/usr/bin/fb_tmpreaper'
  config_src = 'tmpreaper.erb'
else
  fail "Unsupported platform_family #{node['platform_family']}, cannot" +
    'continue'
end

template config do
  source config_src
  mode '0755'
  owner 'root'
  group 'root'
end

if node.macosx?
  launchd 'com.facebook.tmpreaper' do
    action :enable
    program config
    start_calendar_interval(
      'Hour' => 2,
      'Minute' => 2,
    )
  end
end
