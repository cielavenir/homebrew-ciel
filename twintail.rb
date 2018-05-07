# This formula installs "TwinTail de angel-mode", formally known as "AIR-lang".
# Older website (dead): http://air-lang.sourceforge.jp/
# Older manual: https://www20.atwiki.jp/air-lang/

# Note: this formula requires OSX 10.11 (or later) to accept __MATH_LONG_DOUBLE_CONSTANTS.

class Twintail < Formula
	desc 'Programming Language AIR / TwinTail'
	homepage 'http://angelmode.sourceforge.jp/'
	#url 'https://osdn.net/projects/angelmode/downloads/67782/twintail_de_angemode.costume___.tgz'
	url 'http://dl.osdn.jp/angelmode/67782/twintail_de_angelmode.costume208.tgz'
	sha256 '43d52ac31c6628a62efd8cfab325c39f8e97759d1608da29ab09e50b2119d0ea'

	depends_on 'pkg-config' => :build
	depends_on 'libatomic_ops'

	option 'with-oldlibm', 'Build with old libm, disabling tgmath support and long double'
	option 'with-gmtoff', 'Use tm_gmtoff rather than timezone global variable'

	patch :p0 do
		url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/twintail.patch'
		sha256 '0507fed10487792608954545ecbf776fe61bcaa066430ad2d85eefdbd37cb90c'
	end

	def install
		# due to _POSIX_C_SOURCE issue, system() is rvalue, so we need to assign to a variable first.
		system 'sed', '-i', '-e', 's/a->ival=WEXITSTATUS(system(x->str));/{int result=system(x->str);a->ival=WEXITSTATUS(result);}/', 'icode/proc.call/i_proc.c'
		if build.with?(:oldlibm)
			system 'sed', '-i', '-e', 's/#ifdef Linux64/#if 0/', 'admin/mdtype.h'
			system 'sed', '-i', '-e', 's/tgmath.h/math.h/', 'main.h'
		end
		if build.with?(:gmtoff)
			system 'sed', '-i', '-e', 's/gl_gmtoff /{struct tm t;localtime(\&t);gl_gmtoff=t.tm_gmtoff;}\/\//', 'main.c'
		end
		system 'make'
		bin.install 'tt'
	end
end
