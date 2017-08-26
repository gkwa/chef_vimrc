include_recipe 'chef_vimrc::default'

plugin 'https://github.com/SirVer/ultisnips.git' do
  action :delete
end
plugin 'https://github.com/tpope/vim-pathogen.git'
plugin 'https://github.com/altercation/vim-colors-solarized.git'
plugin 'https://github.com/godlygeek/tabular.git'
plugin 'https://github.com/junegunn/fzf.vim.git'
plugin 'https://github.com/kana/vim-textobj-user.git'
plugin 'https://github.com/lacygoill/vim-freekeys.git'
plugin 'https://github.com/mileszs/ack.vim.git'
plugin 'https://github.com/nelstrom/vim-textobj-rubyblock.git'
plugin 'https://github.com/tpope/vim-fugitive.git'
plugin 'https://github.com/tpope/vim-surround.git'
plugin 'https://github.com/tpope/vim-unimpaired.git'
plugin 'https://github.com/vim-airline/vim-airline.git'
plugin 'https://github.com/vim-scripts/mru.vim.git'
plugin 'https://github.com/junegunn/vader.vim'
plugin 'https://github.com/tpope/vim-dispatch.git'
plugin 'https://github.com/tweekmonster/fzf-filemru.git'

%W( vim nvim ).each do |whichvim|
  cookbook_file "#{node['chef_vimrc'][whichvim]['settingsdir']}/taylor-settings.vim" do
    source 'taylor-settings.vim'
  end

  cookbook_file "#{node['chef_vimrc'][whichvim]['settingsdir']}/netrw-settings.vim" do
    source 'netrw-settings.vim'
  end

  cookbook_file "#{node['chef_vimrc'][whichvim]['settingsdir']}/conway-settings.vim" do
    source 'conway-settings.vim'
  end

  cookbook_file "#{node['chef_vimrc'][whichvim]['settingsdir']}/wikia.com-settings.vim" do
    source 'wikia.com-settings.vim'
  end

  template "#{node['chef_vimrc'][whichvim]['settingsdir']}/ultisnips-settings.vim" do
    source 'ultisnips-settings.vim.erb'
    variables({'whichvim': whichvim})
  end
end
