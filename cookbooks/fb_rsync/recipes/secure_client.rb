#
## Cookbook Name:: fb_rsync
## Recipe:: client
##
## Copyright (c) 2019-present, Facebook, Inc.
## All rights reserved.
##
## This source code is licensed under the BSD-style license found in the
## LICENSE file in the root directory of this source tree. An additional grant
## of patent rights can be found in the PATENTS file in the same directory.
##
#
include_recipe 'fb_rsync::packages'
include_recipe 'fb_rsync::stunnel'

cookbook_file '/usr/local/libexec/rsync-ssl-stunnel' do
  owner 'root'
  group 'root'
  mode '0755'
  source 'rsync-ssl-stunnel'
end
