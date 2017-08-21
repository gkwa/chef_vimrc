case node['platform']
when 'windows'
  include_recipe 'chocolatey'

  chocolatey_package 'neovim' do
    action :upgrade
  end
  chocolatey_package 'git'
  chocolatey_package 'fzf' do
    action :upgrade
  end

  windows_path 'c:\tools\neovim\neovim\bin' do
    action :add
  end
else
  package 'neovim' do
    action :upgrade
  end
end

case node['platform']
when 'windows'
  include_recipe 'chocolatey'

  chocolatey_package 'git'
  chocolatey_package 'fzf' do
    action :upgrade
  end

  windows_path 'C:\Program Files\Git\bin' do
    action :add
  end
else
  package 'git'
end
