#!/usr/bin/ruby

#https://github.com/khws4v1/waifu2x-converter-qt/releases/tag/v1.0.0
FNAME='/Applications/waifu2x-converter-qt.app/Contents/MacOS/waifu2x-converter-cpp_files/waifu2x-converter-cpp'

if not File.exist? FNAME
	raise 'cannot find waifu2x-converter-cpp'
end

files=IO.popen(['otool','-L',FNAME],'r'){|io|
	io.read
}.scan(/[\w\.\/\+]+\.dylib/).select{|e|
	e.start_with?('lib/')
}

# use Homebrew's opencv@3 as the attached libopencv's dep-path is weird
cmd=['install_name_tool']+files.flat_map{|e|['-change',e,'@rpath/'+e[4..-1].sub('3.0','3.4')]}+[FNAME]
system(*cmd)
cmd=['install_name_tool','-add_rpath','/usr/local/opt/opencv@3/lib',FNAME]
system(*cmd)
