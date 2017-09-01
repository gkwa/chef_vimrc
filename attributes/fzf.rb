default['chef_vimrc']['fzfdir'] = case node['platform']
                                  when 'windows'
                                    "#{ENV['USERPROFILE']}/.fzf"
                                  else
                                    "#{ENV['HOME']}/.fzf"
                                  end
# don't edit below
default['chef_vimrc']['fzfdir'] = node['chef_vimrc']['fzfdir'].tr('\\', '/')
