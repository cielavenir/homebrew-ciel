class Uasm < Formula
	desc 'UASM Macro Assembler'
	homepage 'http://www.terraspace.co.uk/uasm.html'
	url 'https://github.com/Terraspace/UASM/archive/refs/tags/v2.55.tar.gz'
	sha256 'ae0df97bedd0d3e74e9731ea27d73978b1914aae792d913a3c9029a4d5890192'

	def install
		if OS.mac?
			system 'sed', '-i', '-e', 's/-ansi/-Wno-error=implicit-function-declaration/', 'ClangOSX64.mak'
			system 'make', '-f', 'ClangOSX64.mak'
		else
			system 'make', '-f', 'gccLinux64.mak'
		end
		bin.install 'GccUnixR/uasm'
	end
end
