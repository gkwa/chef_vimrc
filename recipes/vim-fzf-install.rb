directory node['chef_vimrc']['plugindir'] do
  recursive true
end

cookbook_file "#{node['chef_vimrc']['plugindir']}/fzv-settings.vim" do
  source 'fzf-settings.vim'
  backup 10
end

directory node['chef_vimrc']['fzfdir'] do
  recursive true
end

git node['chef_vimrc']['fzfdir'] do
  depth 10
  repository 'https://github.com/junegunn/fzf.git'
  action :sync
end
