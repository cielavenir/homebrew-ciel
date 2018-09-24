# This formula installs "TwinTail de angel-mode", formally known as "AIR-lang".
# Older website (dead): http://air-lang.sourceforge.jp/
# Older manual: https://www20.atwiki.jp/air-lang/

# Note: normal build requires OSX 10.11 (or later) to accept __MATH_LONG_DOUBLE_CONSTANTS. On <=10.10.x --with-oldlibm is required.

class Twintail < Formula
	desc 'Programming Language AIR / TwinTail'
	homepage 'http://angelmode.sourceforge.jp/'
	#url 'https://osdn.net/projects/angelmode/downloads/67782/twintail_de_angemode.costume___.tgz'

	if `uname`.chomp.end_with?('BSD')
		# LinuxBrew running on FreeBSD ( https://qiita.com/cielavenir/items/741921fcecb281555f77 )
		# libc can be very old so that 204 cannot be compiled.
		# Also, --with-oldlibm is required.
		url 'http://dl.osdn.jp/angelmode/67782/twintail_de_angelmode.costume203.tgz'
		sha256 '48d3bab53a2a453954b45c4c3a5976c7174a00822d0d55834ee08c7530caf662'
	else
		url 'http://dl.osdn.jp/angelmode/70059/twintail_de_angelmode.costume223.tgz'
		sha256 'c452e46fdbdae0c395754df910919ff35d455238515eea4cf2ed772e962ce303'
		depends_on 'pkg-config' => :build
		depends_on 'libatomic_ops'
	end

	option 'with-oldlibm', 'Build with old libm, disabling tgmath and long double support'

	patch :p0 do
		url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/twintail.patch'
		sha256 '8ce77911c38451b337ffc383e650020c710b0eda769aa46312424cd72e3f0ddd'
	end

	def install
		# due to _POSIX_C_SOURCE issue, system() is rvalue, so we need to assign to a variable first.
		system 'sed', '-i', '-e', 's/a->ival=WEXITSTATUS(system(x->str));/{int result=system(x->str);a->ival=WEXITSTATUS(result);}/', 'icode/proc.call/i_proc.c'
		# FreeBSD does not support timezone global variable; use tm_gmtoff
		system 'sed', '-i', '-e', 's/gl_gmtoff /{time_t T=time(NULL);struct tm *TM=localtime(\&T);gl_gmtoff=TM->tm_gmtoff;}\/\//', 'main.c'
		if build.with?(:oldlibm)
			#system 'sed', '-i', '-e', 's/#ifdef Linux64/#if 0/', 'admin/mdtype.h'
			system 'sed', '-i', '-e', 's/tgmath.h/math.h/', 'main.h'
		end
		system 'make'
		bin.install 'tt'
	end
end
