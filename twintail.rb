# This formula installs "TwinTail de angel-mode", formally known as "AIR-lang".
# Older website (dead): http://air-lang.sourceforge.jp/
# Older manual: https://www20.atwiki.jp/air-lang/

class TwinTail < Formula
	desc 'Programming Language AIR / TwinTail'
	homepage 'http://angelmode.sourceforge.jp/'
	url 'https://osdn.net/projects/angelmode/downloads/59899/twintail_de_angelmode.costume146.tgz'
	sha256 'a56fbb6fe2f9629e0ae205d310262e210cb444c2c29eb8a35687950b1b9aab85'

	patch :p0 do
		url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/tt.patch'
		sha256 'c66f6f7763c77a913c8e5f880f47778a5ddd46eacd37d6e8632c19188d20a8a1'
	end

	def install
		system 'make'
		bin.install 'tt'
	end
end
