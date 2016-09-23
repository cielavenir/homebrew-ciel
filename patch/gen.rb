#!/usr/bin/ruby
if ARGV.empty?
	STDERR.puts 'gen.rb /path/to/patches'
	exit
end

Dir.chdir(ARGV[0])
if File.exist?('series')
	patch_files=File.open('series'){|f|f.map(&:chomp)}
else
	patch_files=Dir.open('.').to_a
end
patch_files.each{|e|
	File.open(e){|f|puts f.read}
}
