# vim-plug relies on git, so instal git first
case node['platform_family']
when 'windows'
  include_recipe 'chocolatey'
  chocolatey_package 'git'

  windows_path 'C:\Program Files\Git\bin' do
    action :add
  end
else
  package 'git'
end

case node['platform_family']
when 'suse'
  package 'vim-minimal' do
    action :remove
  end
  package 'vim' do
    action :upgrade
  end
  package 'neovim'

when 'fedora'
  package 'vim-minimal' do
    action :remove
  end

  case node['platform_version'].to_f
  when 0.0..24.99
    execute 'add repository dperson/neovim' do
      command <<-EOC
        dnf -y install 'dnf-command(copr)'
        dnf -y copr enable dperson/neovim
      EOC
    end
  when 25.0..999.0
    package 'vim' do
      action :upgrade
    end
  end
  package 'neovim'

when 'rhel'
  case node['platform']
  when 'fedora'
    package 'curl'

    execute 'add repository' do
      command <<-EOC
        curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo \
        https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo
      EOC
    end
    package 'neovim'
  end

  case node['platform']
  when 'centos'
    package %w(epel-release curl)

    execute 'add repository' do
      command <<-EOC
        curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo \
        https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo
      EOC
    end
    package 'neovim'
  end

when 'amazon'
  package %w(epel-release curl)

  execute 'add repository' do
    command <<-EOC
      curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo \
        https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo
    EOC
  end
  package 'neovim'

when 'debian'
  case node['platform']
  when 'ubuntu'
    apt_update 'update'
    directory '/etc/apt/sources.list.d/ppa:neovim-ppa' do
      recursive true
    end

    package 'vim' do
      action :upgrade
    end

    package 'software-properties-common'

    case node['platform_version'].to_f
    when 0.0..12.04
      Chef.Log.Fatal("#{node['platform_version']} is not supported")
      # started down this path but aborted, need to compile cmake, but cmake requires c++11...
      package %w(autoconf automake cmake g++ libncurses5-dev libtool pkg-config unzip build-essential)
      build_dir = "#{Chef::Config[:file_cache_path]}/neovim"
      git build_dir do
        repository 'https://github.com/neovim/neovim.git'
        depth 10
        action :sync
      end
      execute 'make install' do
        cwd build_dir
        command <<-EOC
        make install
        EOC
      end

    when 12.05..14.04
      package 'python-software-properties'
      execute 'add repository' do
        command <<-EOC
        add-apt-repository -y ppa:neovim-ppa/unstable
        apt-get -qqy update
        EOC
      end
    else
      execute 'add repository' do
        command <<-EOC
        add-apt-repository -y ppa:neovim-ppa/stable
        apt-get -qqy update
        EOC
      end
    end
    package 'neovim'

  when 'debian'
    package 'vim'
    if node['platform_version'].to_f >= 9.0
      apt_update 'update'
      package 'neovim'
    else
      package %w(libtool libtool-bin autoconf automake cmake g++ pkg-config unzip)
      build_dir = "#{Chef::Config[:file_cache_path]}/neovim"
      git build_dir do
        repository 'https://github.com/neovim/neovim.git'
        depth 10
        action :sync
      end
      execute 'make install' do
        cwd build_dir
        command <<-EOC
        make install
        EOC
      end
    end
  end

when 'windows'
  chocolatey_package 'neovim' do
    ignore_failure true
  end

  windows_path 'c:\tools\neovim\neovim\bin' do
    action :add
  end

  # vim choco installer doesn't check bittedness, but vim-tux.install does
  pkg = node['kernel']['machine'] == 'x86_64' ? 'vim' : 'vim-tux.install'
  chocolatey_package pkg do
    action :upgrade
  end

  chocolatey_package 'fzf' do
    action :upgrade
  end

  if node['kernel']['machine'] == 'x86_64'
    windows_path 'C:\Program Files (x86)\vim\vim80' do
      action :add
    end
  else
    windows_path 'C:\Program Files\vim\vim80' do
      action :add
    end
  end
end
