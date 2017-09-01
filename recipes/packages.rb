# https://github.com/chef/chef/issues/3215
# unless platform_family?("mac_os_x")

case node['platform_family']
when 'windows'
  include_recipe 'chocolatey'

  chocolatey_package 'neovim' do
    action :upgrade unless platform_family?('mac_os_x')
  end
  chocolatey_package 'git'
  chocolatey_package 'fzf' do
    action :upgrade unless platform_family?('mac_os_x')
  end

  windows_path 'c:\tools\neovim\neovim\bin' do
    action :add
  end
when 'debian'
  apt_update
  package 'software-properties-common'
  directory '/etc/apt/sources.list.d/ppa:neovim-ppa' do
    recursive true
  end

  execute 'add repository' do
    command <<-EOC
    add-apt-repository ppa:neovim-ppa/stable
    apt-get -qqy update
    EOC
  end
  package 'neovim'
else
  package 'neovim' do
    action :upgrade unless platform_family?('mac_os_x')
  end
end

case node['platform_family']
when 'windows'
  include_recipe 'chocolatey'

  chocolatey_package 'git'
  chocolatey_package 'fzf' do
    action :upgrade unless platform_family?('mac_os_x')
  end

  windows_path 'C:\Program Files\Git\bin' do
    action :add
  end
else
  package 'git'
end

case node['platform_family']
when 'windows'
  include_recipe 'chocolatey'
  chocolatey_package 'vim'

  if node['kernel']['machine'] == 'x86_64'
    windows_path 'C:\Program Files (x86)\vim\vim80' do
      action :add
    end
  else
    windows_path 'C:\Program Files\vim\vim80' do
      action :add
    end
  end
end
