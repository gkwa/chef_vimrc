provides :plugin

property :url, String, name_property: true
property :projname, String, default: lazy { |r| r.url.match(%r{(.*\/)+(.*$)})[2].sub('.git', '') }
property :settings, String, default: lazy { |r| "#{r.projname}-settings.vim" }
property :cookbook, String
property :depth, Integer, default: 10

action :create do
  directory "#{node['chef_vimrc']['vimdir']}/bundle" do
    recursive true
  end

  git new_resource.projname do
    depth new_resource.depth
    destination "#{node['chef_vimrc']['vimdir']}/bundle/#{new_resource.projname}"
    repository new_resource.url
    action :sync
  end

  directory node['chef_vimrc']['plugindir'] do
    recursive true
  end

  if ::File.exist?("#{new_resource.cookbook}/#{new_resource.settings}")
    cookbook_file "#{node['chef_vimrc']['plugindir']}/#{new_resource.settings}" do
      source "#{new_resource.cookbook}/#{new_resource.settings}"
    end
  end
end

action :delete do
  directory "#{node['chef_vimrc']['vimdir']}/bundle/#{new_resource.projname}" do
    action :delete
  end

  file "cleanup_#{projname}" do
    path "#{node['chef_vimrc']['plugindir']}/#{new_resourece.settings}"
    action :delete
    if ::File.exist?("#{node['chef_vimrc']['plugindir']}/#{new_resource.settngs}")
      Chef::Log.warn "Deleted #{new_resource.settings}"
    end
  end
end
