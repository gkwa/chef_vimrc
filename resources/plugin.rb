provides :plugin

property :name, String, name_property: true
property :settings, String, default: lazy { |r| "#{r.name}-settings.vim" }
property :cookbook, String
property :depth, Integer, default: 10

action :create do
  directory "#{node['vimrc']['vimdir']}/bundle" do
    recursive true
  end

  dirname = new_resource.name.match(%r{(.*\/)+(.*$)})[2].sub('.git', '')
  git dirname do
    depth new_resource.depth
    destination "#{node['vimrc']['vimdir']}/bundle/#{dirname}"
    repository new_resource.name
    action :sync
  end

  directory node['vimrc']['plugindir'] do
    recursive true
  end

  if ::File.exist?("#{new_resource.cookbook}/#{new_resource.settings}")
    cookbook_file "#{node['vimrc']['plugindir']}/#{new_resourece.name}-settings.vim" do
      source "#{new_resource.cookbook}/#{new_resource.settings}"
    end
  end
end

action :delete do
  file "cleanup_#{new_resource.name}" do
    path "#{node['vimrc']['plugindir']}/#{new_resourece.name}-settings.vim"
    action :delete
    if ::File.exist?("#{node['vimrc']['plugindir']}/#{new_resource.name}-settings.vim")
      Chef::Log.warn "Deleted #{new_resource.name}-settings.vim"
    end
  end
end
