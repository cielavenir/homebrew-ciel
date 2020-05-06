class Waifu2xDeadsix27 < Formula
	desc 'Waifu2x (DeadSix27)'
	homepage 'https://github.com/DeadSix27/waifu2x-converter-cpp'
	head 'https://github.com/DeadSix27/waifu2x-converter-cpp.git'

	depends_on 'opencv'
	depends_on 'llvm@8'

	#keg_only 'to coexist multiple flavor'

	def install
		system 'sed -i -e "s/std::filesystem/std::__fs::filesystem/" src/modelHandler_OpenCL.cpp'
		system 'sed -i -e "s/std::filesystem/std::__fs::filesystem/" src/main.cpp'
		system 'sed -i -e "s/\/usr\/local\/opt\/llvm\//\/usr\/local\/opt\/llvm@8\//g" CMakeLists.txt'
		system 'sed -E -i -e "s/CMAKE_CXX_COMPILER_VERSION VERSION_LESS [0-9\.]+/TRUE/" CMakeLists.txt'
		system "cmake . -DCMAKE_INSTALL_PREFIX=#{prefix}"
		system 'make'
		system 'make install'
	end

	def caveats
		'command name is "waifu2x-converter-cpp".'
	end
end
