### if error happens, `sudo xcode-select -s /Applications/Xcode.app/Contents/Developer` might help.
### no release version as release version does not support macOS.

class Waifu2xUeshita < Formula
	desc 'Waifu2x (ueshita)'
	homepage 'https://github.com/ueshita/waifu2x-converter-glsl'
	head 'https://github.com/ueshita/waifu2x-converter-glsl.git'

	depends_on 'glfw'
	depends_on 'opencv@3'
	depends_on :xcode

	#keg_only 'to coexist multiple flavor'

	def install
		system 'sed -i -e "s/3\.0\.0\.dylib/3\.4\.dylib/g" build/waifu2x-converter-glsl.xcodeproj/project.pbxproj'
		system 'sed -i -e "s/libglfw3/libglfw/g" build/waifu2x-converter-glsl.xcodeproj/project.pbxproj'
		system 'xcodebuild -project build/waifu2x-converter-glsl.xcodeproj -scheme waifu2x-converter-glsl -configuration Release -derivedDataPath DerivedData HEADER_SEARCH_PATHS="/usr/local/opt/opencv@3/include /usr/local/opt/glfw/include '+buildpath+'/include" LIBRARY_SEARCH_PATHS="/usr/local/opt/opencv@3/lib /usr/local/opt/glfw/lib"'
		libexec.install 'DerivedData/Build/Products/Release/waifu2x-converter-glsl'
		libexec.install 'models'
		libexec.install 'shaders'
		#bin.install_symlink libexec/"waifu2x-converter-glsl"
		Dir.mkdir bin
		File.open(bin/"waifu2x-converter-glsl",'w'){|f|
			f.puts("#!/bin/sh")
			f.puts("echo 'note: argument paths needs to be absolute.'")
			# I personally think taking models/shaders from "current directory" is a bug...
			f.puts("cd '"+libexec.to_s+"'")
			f.puts((libexec/"waifu2x-converter-glsl").to_s+' "$@"')
		}
	end

	def caveats
		'command name is "waifu2x-converter-glsl".'
	end
end
