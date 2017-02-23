class Openhsp < Formula
	desc 'Programming Language HSP (open source edition)'
	homepage 'http://www.onionsoft.net/hsp/openhsp/'
	# acknowledgement: http://hsp.tv/play/pforum.php?mode=pastwch&num=67160
	head 'http://guest@dev.onionsoft.net/svn/openhsp/trunk', :using => :svn

	def install
		system 'sed -e "s/--input-charset=cp932 --exec-charset=cp932//" < hsp3/makefile.linux > hsp3/makefile.clang'
		system 'sed -e "s/--input-charset=cp932 --exec-charset=cp932//" < hspcmp/makefile.linux > hspcmp/makefile.clang'
		system 'make -C hsp3 -f makefile.clang'
		system 'make -C hspcmp -f makefile.clang'
		bin.install 'hsp3/hsp3'
		bin.install 'hspcmp/hspcmp'
	end
	def caveats
		'This edition does not use exec-charset, so multibyte handling might be different from original OpenHSP.'
	end
end
