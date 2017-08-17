directory "#{node['vimrc']['vimdir']}/autoload" do
  recursive true
end

remote_file "#{node['vimrc']['vimdir']}/autoload/pathogen.vim" do
  source 'https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim'
  use_last_modified true
end
