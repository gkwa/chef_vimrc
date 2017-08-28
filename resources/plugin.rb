provides :plugin

property :url, String, name_property: true
property :projname, String, default: lazy { |r| r.url.match(%r{(.*\/)+(.*$)})[2].sub('.git', '') }
property :settings, String, default: lazy { |r| "#{r.projname}-settings.vim" }
property :cookbook, String, default: 'chef_vimrc'
property :depth, Integer, default: 1

action :create do
  %W( vim nvim ).each do |whichvim|
    %W( plugindir settingsdir ).each do |mydir|
      directory node['chef_vimrc'][whichvim][mydir] do
        recursive true
        not_if { ::Dir.exist?(node['chef_vimrc'][whichvim][mydir]) }
      end
    end

    template "#{node['chef_vimrc'][whichvim]['basedir']}/#{node['chef_vimrc'][whichvim]['initfile']}" do
      cookbook new_resource.cookbook if new_resource.cookbook
      source "#{node['chef_vimrc'][whichvim]['initfile']}.erb"
      variables({'whichvim': whichvim})
    end

    d = node['chef_vimrc'][whichvim]['plugindir']
    git new_resource.projname do
      depth new_resource.depth
      destination "#{d}/#{new_resource.projname}"
      repository new_resource.url
      action :sync
      # protect against cygwin's git:
      if node['platform_family'] == 'windows'
        environment 'PATH' => 'C:\Program Files (x86)\Git\bin;C:\Program Files\Git\bin;$env:PATH'
      end
    end

    d = node['chef_vimrc'][whichvim]['settingsdir']
    cookbook_file "#{d}/#{new_resource.settings}" do
      cookbook new_resource.cookbook
      only_if {
        run_context.has_cookbook_file_in_cookbook?(
          new_resource.cookbook, new_resource.settings)
      }
    end
  end
end

action :delete do
  %W( vim nvim ).each do |whichvim|
    d = node['chef_vimrc'][whichvim]['plugindir']
    directory "#{d}/#{new_resource.projname}" do
      action :delete
      recursive true
    end

    d = node['chef_vimrc'][whichvim]['plugindir']
    file "cleanup_#{new_resource.projname}" do
      path "#{d}/#{new_resource.settings}"
      action :delete
      if ::File.exist?("#{d}/#{new_resource.settings}")
        Chef::Log.warn "Deleted #{new_resource.settings}"
      end
    end
  end
end
