class SubversionGuestDownloadStrategy < SubversionDownloadStrategy
	if respond_to?(:quiet_safe_system,true)
		alias quiet_safe_system_real quiet_safe_system
		def quiet_safe_system(*args)
			# acknowledgement: http://hsp.tv/play/pforum.php?mode=pastwch&num=67160
			args+=%w(--username guest --password guest) if args.size>1&&%w(up update co checkout).include?(args[1])
			quiet_safe_system_real(*args)
		end
	elsif respond_to?(:safe_system,true)
		alias safe_system_real safe_system
		def safe_system(*args)
			# acknowledgement: http://hsp.tv/play/pforum.php?mode=pastwch&num=67160
			args+=%w(--username guest --password guest) if args.size>1&&%w(up update co checkout).include?(args[1])
			safe_system_real(*args)
		end
	else
		raise 'SubversionGuestDownloadStrategy cannot get loaded'
	end
end

class Openhsp < Formula
	desc 'Programming Language HSP (open source edition)'
	homepage 'http://www.onionsoft.net/hsp/openhsp/'
	head 'http://dev.onionsoft.net/svn/openhsp/trunk', :using => SubversionGuestDownloadStrategy

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
