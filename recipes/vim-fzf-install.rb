cookbook_file "#{node['vimrc']['plugindir']}/fzv.vim" do
  source 'fzf.vim'
  backup 10
end

git node['vimrc']['fzfdir'] do
  depth 10
  repository 'https://github.com/junegunn/fzf.git'
  action :sync
end
