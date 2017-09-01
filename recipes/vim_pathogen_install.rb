%w(vim nvim).each do |whichvim|
  directory "#{node['chef_vimrc'][whichvim]['basedir']}/autoload" do
    recursive true
  end

  remote_file "#{node['chef_vimrc'][whichvim]['basedir']}/autoload/pathogen.vim" do
    source 'https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim'
    use_last_modified true
  end
end
