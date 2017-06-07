# This formula installs "TwinTail de angel-mode", formally known as "AIR-lang".
# Older website (dead): http://air-lang.sourceforge.jp/
# Older manual: https://www20.atwiki.jp/air-lang/

class Twintail < Formula
	desc 'Programming Language AIR / TwinTail'
	homepage 'http://angelmode.sourceforge.jp/'
	url 'https://osdn.net/projects/angelmode/downloads/67782/twintail_de_angelmode.costume202.tgz'
	sha256 '1a4dadadd2b9786b6a5fbcb7cd61f0d619a2b9e995f878a0633daa5d7f587800'

	patch :p0 do
		url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/twintail.patch'
		sha256 '122ef9dcaee19f067e58dcf7d1b4c6d06f1758502159ef87a4fcd6386b786d5b'
	end

	def install
		system 'sed', '-i', '-e', 's/a->ival=WEXITSTATUS(system(x->str));/{int result=system(x->str);a->ival=WEXITSTATUS(result);}/', 'icode/proc.call/i_proc.c'
		system 'make'
		bin.install 'tt'
	end
end
