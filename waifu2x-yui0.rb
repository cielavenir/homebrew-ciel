class Waifu2xYui0 < Formula
	desc 'Waifu2x (yui0)'
	homepage 'https://github.com/yui0/waifu2x-glsl'
	head 'https://github.com/yui0/waifu2x-glsl.git'

	depends_on 'glfw'
	depends_on 'opencv@3'

	#keg_only 'to coexist multiple flavor'

	def install
		system 'make'
		libexec.install 'waifu2x_glsl'
		libexec.install 'models'
		libexec.install 'vgg_7'
		bin.install_symlink libexec/"waifu2x_glsl"
	end

	def caveats
		'command name is "waifu2x_glsl". also, need to specify model file in absolute path (under '+libexec.to_s+').'
	end
end
