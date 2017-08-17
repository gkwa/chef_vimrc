include_recipe 'vimrc::packages'
include_recipe 'vimrc::vim-plug-install'
include_recipe 'vimrc::vim-fzf-install'

template "#{node['vimrc']['vimdir']}/vimrc" do
  source 'vimrc.erb'
end

directory node['vimrc']['plugindir'] do
  recursive true
end

cookbook_file "#{node['vimrc']['plugindir']}/conway.vim" do
  source 'conway.vim'
  backup 10
end

cookbook_file "#{node['vimrc']['plugindir']}/taylor.vim" do
  source 'taylor.vim'
  backup 10
end

cookbook_file "#{node['vimrc']['plugindir']}/wikia.com.vim" do
  source 'wikia.com.vim'
  backup 10
end

cookbook_file "#{node['vimrc']['plugindir']}/ultrasnips.vim" do
  source 'ultrasnips.vim'
  backup 10
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
