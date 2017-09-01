include_recipe 'chef_vimrc::default'

%w(vim nvim).each do |whichvim|
  %w(plugindir).each do |mydir|
    directory node['chef_vimrc'][whichvim][mydir] do
      recursive true
    end
  end

  template "#{node['chef_vimrc'][whichvim]['basedir']}/#{node['chef_vimrc'][whichvim]['initfile']}" do
    source 'vimrc.vim.erb'
    variables 'whichvim' => whichvim
  end

  execute 'PluginInstall' do
    command "#{whichvim} slient! +VimEnter +PlugInstall +qall"
  end

  execute 'PluginUpdate' do
    command "#{whichvim} slient! +VimEnter +PlugUpdate +qall"
  end
end
