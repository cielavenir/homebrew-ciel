class Blawn < Formula
	desc 'Programming Language Blawn'
	homepage 'https://github.com/Naotonosato/Blawn'
	head 'https://github.com/cielavenir/Blawn.git', :branch => 'macOS'

	depends_on 'bison'
	depends_on 'flex'
	depends_on 'llvm@8'

	def install
		system 'make -C src/build'
		libexec.install 'src/build/bin/blawn'
		(libexec/'data').install 'src/build/bin/data/builtins.o'
		Dir.mkdir libexec/"tmp"
		bin.install_symlink libexec/"blawn"
	end
	def caveats
		"This formula is shipped with some specific patches. Although test is available, I am not taking any responsibilities.\n"+
		"Also, you need to add /usr/local/opt/llvm@8/bin to $PATH.\n"+
		"HOMEBREW_NO_SANDBOX=1 IS REQUIRED WHEN YOU RUN 'brew test blawn'."
	end

	test do
		ENV['PATH']='/usr/local/opt/llvm@8/bin:'+ENV['PATH']
		(testpath/"hello.blawn").write <<~EOS
			print("Hello, world!")
		EOS
		assert_equal "Hello, world!\n", `#{bin}/blawn hello.blawn`
	end
end
