%W( vim nvim ).each do |whichvim|
  %W( basedir plugindir settingsdir).each do |mydir|
    directory node['chef_vimrc'][whichvim][mydir] do
      recursive true
    end
  end

  cookbook_file "#{node['chef_vimrc'][whichvim]['settingsdir']}/fzv-settings.vim" do
    source 'fzf-settings.vim'
    backup 10
  end
end

directory node['chef_vimrc']['fzfdir'] do
  recursive true
end

git node['chef_vimrc']['fzfdir'] do
  depth 10
  repository 'https://github.com/junegunn/fzf.git'
  action :sync
  # protect against cygwin's git:
  environment 'PATH' => 'C:\Program Files\Git\bin;$env:PATH'
end
