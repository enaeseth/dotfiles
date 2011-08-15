require 'rake'
require 'erb'

IGNORED_FILES = %w(Rakefile README.markdown LICENSE)

desc "install files into the user's home directory"
task :install do
  replace_all = false

  Dir['*'].each do |filename|
    next if IGNORED_FILES.include? filename

    clean_filename = filename.sub('.erb', '')
    dest_filename = ".#{clean_filename}"
    dest_path = File.join(ENV['HOME'], dest_filename)

    if File.exist?(dest_path)
      if File.identical?(filename, dest_path)
        puts "identical ~/#{dest_filename}"
      elsif replace_all
        replace_file filename, dest_filename, dest_path
      else
        answer = prompt("overwrite ~/#{dest_filename}? [ynaq]")
        case answer
        when 'a', 'y'
          replace_all = true if answer == 'a'
          replace_file filename, dest_filename, dest_path
        when 'q'
          exit
        else
          puts "skipping ~/#{dest_filename}"
        end
      end
    else
      install_file filename, dest_filename, dest_path
    end
  end
end

def prompt(question)
  print "#{question} "
  STDOUT.flush
  STDIN.gets.chomp
end

def replace_file(source_filename, dest_filename, dest_path)
  system %Q{rm -rf "#{dest_path}"}
  install_file source_filename, dest_filename, dest_path
end

def install_file(source_filename, dest_filename, dest_path)
  if source_filename =~ /\.erb$/
    puts "generating ~/#{dest_filename}"
    File.open(dest_path, 'w') do |new_file|
      new_file.write ERB.new(File.read(source_filename)).result(binding)
    end
  else
    puts "linking ~/#{dest_filename}"
    system %Q{ln -s "$PWD/#{source_filename}" "$HOME/#{dest_filename}"}
  end
end
