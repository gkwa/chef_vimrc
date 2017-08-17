default['chef_vimrc']['basedir'] = ENV['HOME']
default['chef_vimrc']['vimdir'] = case node['platform']
                             when 'windows'
                               "#{node['chef_vimrc']['basedir']}/vimfiles"
                             else
                               "#{node['chef_vimrc']['basedir']}/.vim"
                             end
default['chef_vimrc']['plugindir'] = "#{node['chef_vimrc']['vimdir']}/bundle/miscellaneous/plugin"
