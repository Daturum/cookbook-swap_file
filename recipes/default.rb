#
# Cookbook Name:: swap_file
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

if node['virtualization']['system'] == 'lxc' && !node['swap_file']['run_on_lxc']
  Chef::Log.warn("Using LXC virtualization and node['swap_file']['run_on_lxc'] = false, then skiping create swap files")
  return
end

directory node['swap_file']['directory'] do
  mode '0700'
  recursive true
end

(1..node['swap_file']['count'].to_i).each do |index|
  swap_file "#{node['swap_file']['directory']}/file#{index}" do
    size node['swap_file']['size'].to_i
    persist node['swap_file']['persist']
  end
end
