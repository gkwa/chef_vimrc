directory node['vimrc']['plugindir'] do
  recursive true
end

cookbook_file "#{node['vimrc']['plugindir']}/fzv-settings.vim" do
  source 'fzf-settings.vim'
  backup 10
end

directory node['vimrc']['fzfdir'] do
  recursive true
end

git node['vimrc']['fzfdir'] do
  depth 10
  repository 'https://github.com/junegunn/fzf.git'
  action :sync
end
