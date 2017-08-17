default['vimrc']['basedir'] = ENV['HOME']
default['vimrc']['vimdir'] = case node['platform']
                             when 'windows'
                               "#{node['vimrc']['basedir']}/vimfiles"
                             else
                               "#{node['vimrc']['basedir']}/.vim"
                             end
default['vimrc']['plugindir'] = "#{node['vimrc']['vimdir']}/bundle/miscellaneous/plugin"
