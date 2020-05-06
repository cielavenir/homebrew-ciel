class SubversionGuestDownloadStrategy < SubversionDownloadStrategy
	# need '--username guest --password guest' in svn argument
	# acknowledgement: http://hsp.tv/play/pforum.php?mode=pastwch&num=67160
	loaded = false
	if respond_to?(:quiet_safe_system,true)
		alias quiet_safe_system_real quiet_safe_system
		def quiet_safe_system(*args)
			args+=%w(--username guest --password guest) if args.size>1&&%w(up update co checkout).include?(args[1])
			quiet_safe_system_real(*args)
		end
		loaded = true
	end
	if respond_to?(:safe_system,true)
		alias safe_system_real safe_system
		def safe_system(*args)
			args+=%w(--username guest --password guest) if args.size>1&&%w(up update co checkout).include?(args[1])
			safe_system_real(*args)
		end
		loaded = true
	end
	if respond_to?(:system_command!,true)
		alias system_command_real! system_command!
		def system_command!(*args,**options)
			options[:args]+=%w(--username guest --password guest) if options[:args].size>1&&%w(up update co checkout).include?(options[:args][0])
			system_command_real!(*args,**options)
		end
		loaded = true
	end
	if !loaded
		raise 'SubversionGuestDownloadStrategy cannot get loaded'
	end
end

class Openhsp < Formula
	desc 'Programming Language HSP (open source edition)'
	homepage 'http://www.onionsoft.net/hsp/openhsp/'
	#head 'http://dev.onionsoft.net/svn/openhsp/trunk', :using => SubversionGuestDownloadStrategy
	head 'https://github.com/onitama/OpenHSP.git', :revision => "c393102795caab97ec61803900235d7b7569a787"

	def install
		system 'sed -e "s/--input-charset=cp932 --exec-charset=cp932//" < src/hsp3/makefile.linux > src/hsp3/makefile.clang'
		system 'sed -e "s/--input-charset=cp932 --exec-charset=cp932//" < src/hspcmp/makefile.linux > src/hspcmp/makefile.clang'
		system 'make -C src/hsp3 -f makefile.clang'
		system 'make -C src/hspcmp -f makefile.clang'
		bin.install 'src/hsp3/hsp3'
		bin.install 'src/hspcmp/hspcmp'
	end

	def caveats
		'This edition does not use exec-charset, so multibyte handling might be different from original OpenHSP.'
	end

	test do
		(testpath/"hello.hsp").write <<~EOS
			mes "Hello, world!"
			end
		EOS
		system "#{bin}/hspcmp", "hello.hsp"
		assert_equal "Hello, world!\n", `#{bin}/hsp3 hello.ax`
	end
end
