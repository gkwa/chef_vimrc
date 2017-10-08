if os.windows?
  describe command('C:/Program Files/vim/vim80/vim.exe --version') do
    its('exit_status') { should eq 0 }
  end
  describe command('C:/Program Files (x86)/vim/vim80/vim.exe --version') do
    its('exit_status') { should eq 0 }
  end
  describe command('C:\Program\ Files\vim\vim80\vim.exe --version') do
    its('exit_status') { should eq 0 }
  end
  describe command('C:\Program Files\vim\vim80\vim.exe --version') do
    its('exit_status') { should eq 0 }
  end
  describe command('C:\Program Files (x86)\vim\vim80\vim.exe --version') do
    its('exit_status') { should eq 0 }
  end
  describe command('C:\tools\neovim\Neovim\bin\nvim.exe --version') do
    its('exit_status') { should eq 0 }
  end
else
  describe command('vim --version') do
    its('exit_status') { should eq 0 }
  end
  describe command('nvim --version') do
    its('exit_status') { should eq 0 }
  end
end
