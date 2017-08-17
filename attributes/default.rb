default['vimrc']['basedir'] = ENV['HOME']
default['vimrc']['fzfdir'] = "#{ENV['HOME']}/.fzf"
default['vimrc']['vimdir'] = case node['platform']
                             when 'windows'
                               "#{node['vimrc']['basedir']}/vimfiles"
                             else
                               "#{node['vimrc']['basedir']}/.vim"
                             end
default['vimrc']['plugins'] = {
  'https://github.com/dbakker/vim-projectroot.git' => { '' => '' },
  'https://github.com/junegunn/vim-plug.git' => { '' => '' },
  'https://github.com/tpope/vim-pathogen.git' => { '' => '' },
  'https://github.com/SirVer/ultisnips.git' => { '' => '' },
  'https://github.com/airblade/vim-rooter.git' => { '' => '' },
  'https://github.com/altercation/vim-colors-solarized.git' => { '' => '' },
  'https://github.com/godlygeek/tabular.git' => { '' => '' },
  'https://github.com/junegunn/fzf.vim.git' => { '' => '' },
  'https://github.com/kana/vim-textobj-user.git' => { '' => '' },
  'https://github.com/lacygoill/vim-freekeys.git' => { '' => '' },
  'https://github.com/mileszs/ack.vim.git' => { '' => '' },
  'https://github.com/nelstrom/vim-textobj-rubyblock.git' => { '' => '' },
  'https://github.com/tpope/vim-fugitive.git' => { '' => '' },
  'https://github.com/tpope/vim-surround.git' => { '' => '' },
  'https://github.com/tpope/vim-unimpaired.git' => { '' => '' },
  'https://github.com/vim-airline/vim-airline.git' => { '' => '' },
  'https://github.com/vim-scripts/mru.vim.git' => { '' => '' },
}
