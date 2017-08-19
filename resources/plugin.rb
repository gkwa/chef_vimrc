provides :plugin

property :url, String, name_property: true
property :projname, String, default: lazy { |r| r.url.match(%r{(.*\/)+(.*$)})[2].sub('.git', '') }
property :settings, String, default: lazy { |r| "#{r.projname}-settings.vim" }
property :cookbook, String, default: 'chef_vimrc'
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

  cookbook_file "#{node['chef_vimrc']['plugindir']}/#{new_resource.settings}" do
    cookbook new_resource.cookbook if new_resource.cookbook
    only_if {
      run_context.has_cookbook_file_in_cookbook?(
        new_resource.cookbook, new_resource.settings)
    }
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
