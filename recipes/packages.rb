case node['platform']
when 'windows'
  include_recipe 'chocolatey'

  chocolatey_package 'git'
  chocolatey_package 'fzf'

  windows_path 'C:\Program Files\Git\bin' do
    action :add
  end
else
  package 'git'
end
