# This formula installs "TwinTail de angel-mode", formally known as "AIR-lang".
# Older website (dead): http://air-lang.sourceforge.jp/
# Older manual: https://www20.atwiki.jp/air-lang/

# Note: normal build requires OSX 10.11 (or later) to accept __MATH_LONG_DOUBLE_CONSTANTS. On <=10.10.x --with-oldlibm is required.

class Twintail < Formula
	desc 'Programming Language AIR / TwinTail'
	homepage 'http://angelmode.sourceforge.jp/'
	#url 'https://osdn.net/projects/angelmode/downloads/67782/twintail_de_angemode.costume___.tgz'

	### Hopefully gc-7.6 compilation issue looks fixed upstream.
	### However, --with-oldlibm is still required.

	#if `uname`.chomp.end_with?('BSD')
		# LinuxBrew running on FreeBSD ( https://qiita.com/cielavenir/items/741921fcecb281555f77 )
		# libc can be very old so that 204 cannot be compiled.
		# Also, --with-oldlibm is required.
	#	url 'http://osdn.dl.osdn.jp/angelmode/67782/twintail_de_angelmode.costume203.tgz'
	#	sha256 '48d3bab53a2a453954b45c4c3a5976c7174a00822d0d55834ee08c7530caf662'
	#else
		#url 'http://osdn.dl.osdn.jp/angelmode/70059/twintail_de_angelmode.costume223.tgz'
		#sha256 'c452e46fdbdae0c395754df910919ff35d455238515eea4cf2ed772e962ce303'
		url 'http://osdn.dl.osdn.jp/angelmode/70474/twintail_de_angelmode.costume245.tgz'
		sha256 'f4526be24c162984707c5105b1abeca071fc211da7536b2810feef5db9666d50'
		depends_on 'pkg-config' => :build
		depends_on 'libatomic_ops'
	#end

	option 'with-oldlibm', 'Build with old libm, disabling tgmath and long double support'

	bottle do
		root_url "https://dl.bintray.com/cielavenir/homebrew"
		sha256 cellar: :any_skip_relocation, sierra: "04e1461bba776897abe87b9a4c9aa8599beee5b3b05c840ea9d906b2f7292998"
	end

	if `uname`.chomp.end_with?('BSD') || `uname`.chomp=='Darwin'
		patch :p1 do
			url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/twintail_disablenet.patch'
			sha256 '2f2653919070b5a0861e09a426a7c7a68087988c39b4d2496c7f40decd101acf'
		end

		def caveats
			'Network functions are disabled.'
		end
	end

	patch :p0 do
		url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/twintail.patch'
		sha256 '45ed23b29068774fb9e3b13d7a151864a771d4ff5e0d15be81cb772a0415a537'
	end

	def install
		if `uname`.chomp.end_with?('BSD') || `uname`.chomp=='Darwin'
			system 'rm', '-rf', 'icode/inet.call'
		end

		# due to _POSIX_C_SOURCE issue, system() is rvalue, so we need to assign to a variable first.
		system 'sed', '-i', '-e', 's/a->ival=WEXITSTATUS(system(x->str));/{int result=system(x->str);a->ival=WEXITSTATUS(result);}/', 'icode/proc.call/i_proc.c'
		# FreeBSD does not support timezone global variable; use tm_gmtoff
		system 'sed', '-i', '-e', 's/gl_gmtoff /{time_t T=time(NULL);struct tm *TM=localtime(\&T);gl_gmtoff=TM->tm_gmtoff;}\/\//', 'main.c'
		if build.with?(:oldlibm)
			system 'sed', '-i', '-e', 's/tgmath.h/math.h/', 'main.h'
		end
		system 'make'
		bin.install 'tt'
	end

	test do
		(testpath/"hello.tt").write <<~EOS
			print("Hello, world!");
		EOS
		assert_equal "Hello, world!", `#{bin}/tt hello.tt`
	end
end
