# https://github.com/junegunn/vim-plug#installation

directory node['vimrc']['plugindir'] do
  recursive true
end

directory "#{node['vimrc']['vimdir']}/autoload" do
  recursive true
end

remote_file "#{node['vimrc']['vimdir']}/autoload/plug.vim" do
  source 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  use_last_modified true
end

template "#{node['vimrc']['plugindir']}/vim-plug-settings.vim" do
  source 'vim-plug-settings.vim.erb'
end
