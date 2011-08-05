#!/usr/bin/env ruby

git_bundles = [
  "git://github.com/altercation/vim-colors-solarized.git",
  "git://github.com/chrismetcalf/vim-yankring.git",
  "git://github.com/digitaltoad/vim-jade.git",
  "git://github.com/ervandew/supertab.git",
  "git://github.com/kchmck/vim-coffee-script.git",
  "git://github.com/Raimondi/delimitMate.git",
  "git://github.com/othree/html5.vim.git",
  "git://github.com/scrooloose/nerdtree.git",
  "git://github.com/scrooloose/nerdcommenter.git",
  "git://github.com/scrooloose/syntastic.git",
  "git://github.com/sjl/gundo.vim.git",
  "git://github.com/timcharper/textile.vim.git",
  "git://github.com/tpope/vim-fugitive.git",
  "git://github.com/tpope/vim-haml.git",
  "git://github.com/tpope/vim-markdown.git",
  "git://github.com/tpope/vim-repeat.git",
  "git://github.com/tpope/vim-surround.git",
  "git://github.com/tpope/vim-unimpaired.git",
  "git://github.com/vim-ruby/vim-ruby.git",
  "git://github.com/mileszs/ack.vim.git",
  "git://git.wincent.com/command-t.git",
]

vim_org_scripts = [
  ["IndexedSearch", "7062",  "plugin"],
  ["gist",          "15452", "plugin"],
  ["jquery",        "12276", "syntax"],
]

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")
FileUtils.mkdir_p(bundles_dir) unless File.directory?(bundles_dir)

FileUtils.cd(bundles_dir)

puts "Trashing everything (lookout!)"
Dir["*"].each {|d| FileUtils.rm_rf d }

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '')
  puts "  Unpacking #{url} into #{dir}"
  `git clone #{url} #{dir}`
  FileUtils.rm_rf(File.join(dir, ".git"))
end

vim_org_scripts.each do |name, script_id, script_type|
  puts "  Downloading #{name}"
  local_file = File.join(name, script_type, "#{name}.vim")
  FileUtils.mkdir_p(File.dirname(local_file))
  File.open(local_file, "w") do |file|
    file << open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}").read
  end
end

FileUtils.cd('command-t')
`rake make`
