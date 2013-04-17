require 'rake'
require 'erb'

IGNORED_FILES = %w(Rakefile README.markdown LICENSE)

desc "install files into the user's home directory"
task :install do
  replace_all = false

  Dir['*'].each do |filename|
    next if IGNORED_FILES.include? filename

    clean_filename = filename.sub('.erb', '').sub(/^(ssh)_/, '\1/')
    dest_filename = ".#{clean_filename}"
    dest_path = File.join(ENV['HOME'], dest_filename)

    if File.exist?(dest_path)
      if File.identical?(filename, dest_path)
        puts "identical ~/#{dest_filename}"
      elsif replace_all
        install_file filename, dest_filename, dest_path
      else
        answer = prompt("overwrite ~/#{dest_filename}? [ynaq]")
        case answer
        when 'a', 'y'
          replace_all = true if answer == 'a'
          install_file filename, dest_filename, dest_path
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

def prompt(question, current_value=nil)
  if current_value and current_value != ""
    puts "#{question} #{current_value}"
    STDOUT.flush
    current_value
  else
    print "#{question} "
    STDOUT.flush
    STDIN.gets.chomp
  end
end

def install_file(source_filename, dest_filename, dest_path)
  if source_filename =~ /\.erb$/
    puts "generating ~/#{dest_filename}"

    contents = ERB.new(File.read(source_filename)).result(binding)
    File.open(dest_path, 'w') do |new_file|
      new_file.write contents
    end
  else
    puts "linking ~/#{dest_filename}"
    system %Q{rm -rf "#{dest_path}"} if File.exist?(dest_path)
    system %Q{ln -s "$PWD/#{source_filename}" "$HOME/#{dest_filename}"}
  end
end
