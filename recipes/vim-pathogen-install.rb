directory "#{node['chef_vimrc']['vimdir']}/autoload" do
  recursive true
end

remote_file "#{node['chef_vimrc']['vimdir']}/autoload/pathogen.vim" do
  source 'https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim'
  use_last_modified true
end
