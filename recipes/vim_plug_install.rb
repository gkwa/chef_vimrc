# https://github.com/junegunn/vim-plug#installation

%w(vim nvim).each do |whichvim|
  directory node['chef_vimrc'][whichvim]['plugindir'] do
    recursive true
  end

  directory "#{node['chef_vimrc'][whichvim]['basedir']}/autoload" do
    recursive true
  end

  remote_file "#{node['chef_vimrc'][whichvim]['basedir']}/autoload/plug.vim" do
    source 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    use_last_modified true
  end
end
