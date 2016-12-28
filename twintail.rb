# This formula installs "TwinTail de angel-mode", formally known as "AIR-lang".
# Older website (dead): http://air-lang.sourceforge.jp/
# Older manual: https://www20.atwiki.jp/air-lang/

class Twintail < Formula
	desc 'Programming Language AIR / TwinTail'
	homepage 'http://angelmode.sourceforge.jp/'
	url 'https://osdn.net/projects/angelmode/downloads/59899/twintail_de_angelmode.costume146.tgz'
	sha256 'a56fbb6fe2f9629e0ae205d310262e210cb444c2c29eb8a35687950b1b9aab85'

	patch :p0 do
		url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/twintail.patch'
		sha256 'b6de0245fd40cae65a7f7b12df4be42777c258a994bbd7e563489ff5235702ae'
	end

	def install
		system 'make'
		bin.install 'tt'
	end
end
