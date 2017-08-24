default['chef_vimrc']['vim']['homedir'] = ENV['HOME'].tr('\\','/')
default['chef_vimrc']['nvim']['homedir'] = case node['platform']
                                          when 'windows'
                                            ENV['LOCALAPPDATA'].tr('\\','/')
                                          else
                                            "#{ENV['HOME']}/.config".tr('\\','/')
                                          end
default['chef_vimrc']['vim']['initfile'] = 'vimrc'
default['chef_vimrc']['nvim']['initfile'] = 'init.vim'

default['chef_vimrc']['vim']['basedir'] = case node['platform']
                                          when 'windows'
                                            "#{node['chef_vimrc']['vim']['homedir']}/vimfiles"
                                          else
                                            "#{node['chef_vimrc']['vim']['homedir']}/.vim"
                                          end
default['chef_vimrc']['nvim']['basedir'] = "#{node['chef_vimrc']['nvim']['homedir']}/nvim"
default['chef_vimrc']['nvim']['basedir'] = "#{node['chef_vimrc']['nvim']['homedir']}/nvim"

default['chef_vimrc']['vim']['plugindir'] = "#{node['chef_vimrc']['vim']['basedir']}/bundle"
default['chef_vimrc']['nvim']['plugindir'] = "#{node['chef_vimrc']['nvim']['basedir']}/plugged"

default['chef_vimrc']['vim']['settingsdir'] = "#{node['chef_vimrc']['vim']['basedir']}/bundle/miscellaneous/plugin"
default['chef_vimrc']['nvim']['settingsdir'] = "#{node['chef_vimrc']['nvim']['basedir']}/plugged/miscellaneous/plugin"
