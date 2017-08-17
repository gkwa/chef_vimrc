include_recipe 'vimrc::packages'

# vim-patogen setup
directory "#{node['vimrc']['vimdir']}/autoload" do
  recursive true
end

plugindir = "#{node['vimrc']['vimdir']}/bundle/miscellaneous/plugin"

directory plugindir do
  recursive true
end

cookbook_file "#{plugindir}/conway.vim" do
  source 'conway.vim'
  backup 10
end

template "#{node['vimrc']['vimdir']}/vimrc" do
  source 'vimrc.erb'
end

template "#{plugindir}/vim-plug.vim" do
  source 'vim-plug.vim.erb'
end

cookbook_file "#{plugindir}/taylor.vim" do
  source 'taylor.vim'
  backup 10
end

cookbook_file "#{plugindir}/fzv.vim" do
  source 'fzf.vim'
  backup 10
end

cookbook_file "#{plugindir}/wikia.com.vim" do
  source 'wikia.com.vim'
  backup 10
end

cookbook_file "#{plugindir}/ultrasnips.vim" do
  source 'ultrasnips.vim'
  backup 10
end

# install vim-plug
remote_file "#{node['vimrc']['vimdir']}/autoload/plug.vim" do
  source 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  use_last_modified true
end
git "#{node['vimrc']['fzfdir']}" do
  depth 10
  repository 'https://github.com/junegunn/fzf.git'
  action :sync
end

remote_file "#{node['vimrc']['vimdir']}/autoload/pathogen.vim" do
  source 'https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim'
  use_last_modified true
end

node['vimrc']['plugins'].each do |plugin, _metadata|
  dirname = plugin.match(%r{(.*\/)+(.*$)})[2].sub('.git', '')
  directory "#{node['vimrc']['vimdir']}/bundle" do
    recursive true
  end

  git dirname do
    depth 20
    destination "#{node['vimrc']['vimdir']}/bundle/#{dirname}"
    repository plugin
    action :sync
  end
end

directory "#{node['vimrc']['vimdir']}/bundle/vim-plug/plugin" do
  recursive true
end

remote_file "#{node['vimrc']['vimdir']}/bundle/vim-plug/plugin/plug.vim" do
  source 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  use_last_modified true
end
