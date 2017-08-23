# https://github.com/chef/chef/issues/3215
# unless platform_family?("mac_os_x")

case node['platform']
when 'windows'
  include_recipe 'chocolatey'

  chocolatey_package 'neovim' do
    action :upgrade unless platform_family?("mac_os_x")
  end
  chocolatey_package 'git'
  chocolatey_package 'fzf' do
    action :upgrade unless platform_family?("mac_os_x")
  end

  windows_path 'c:\tools\neovim\neovim\bin' do
    action :add
  end
else
  package 'neovim' do
    action :upgrade unless platform_family?("mac_os_x")
  end
end

case node['platform']
when 'windows'
  include_recipe 'chocolatey'

  chocolatey_package 'git'
  chocolatey_package 'fzf' do
    action :upgrade unless platform_family?("mac_os_x")
  end

  windows_path 'C:\Program Files\Git\bin' do
    action :add
  end
else
  package 'git'
end
