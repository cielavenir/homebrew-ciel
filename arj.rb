class Arj < Formula
	desc 'create and extract files from dos .arj archives'
	homepage 'http://arj.sourceforge.net/'
	url 'http://arj.sourceforge.net/files/arj-3.10.22.tar.gz'
	sha256 '589e4c9bccc8669e7b6d8d6fcd64e01f6a2c21fe10aad56a83304ecc3b96a7db'

	patch :p0 do
		url 'https://trac.macports.org/export/153066/trunk/dports/archivers/arj/files/patch-configure.in'
		sha256 'b86f18a14d289c10dcf92b544b616fce5c0c3c6b293da4438935598761bafeab'
	end
	patch :p0 do
		url 'https://trac.macports.org/export/153066/trunk/dports/archivers/arj/files/patch-environ.c'
		sha256 '5bdce32f97f061114e781b0cfa05b748a3bada2e251b9f2a827c94ab0b60f813'
	end
	patch :p0 do
		url 'https://trac.macports.org/export/153066/trunk/dports/archivers/arj/files/patch-makefile.in'
		sha256 'ed8b2c7c3082df17847586c5efb82b9bad3a3f8fd27ee1b301cd9be5cb7e0a05'
	end
	patch :p0 do
		url 'https://trac.macports.org/export/153066/trunk/dports/archivers/arj/files/patch-postproc.c'
		sha256 '318a17fe3df478f6ba01be4863174b8c63a45d027f263f23b6e97474832d5d67'
	end
	patch :p0 do
		url 'https://trac.macports.org/export/153066/trunk/dports/archivers/arj/files/patch-uxspec.c'
		sha256 'a4a332c9e7015f9b32f3bcc73966653dcbe606ec8e44e7d6fb08216aae828eee'
	end

	def caveats
		'x86_64 edition could be broken. Always use with "arch -i386".'
	end

	def install
		ENV.universal_binary
		uname=`uname -r`.chomp
		system 'sed', '-i', '-e', 's/strnlen/arjstrnlen/g', 'fardata.c'
		Dir.chdir('gnu')
		system 'cp', "#{HOMEBREW_PREFIX}/share/libtool/build-aux/config.guess", './'
		system 'cp', "#{HOMEBREW_PREFIX}/share/libtool/build-aux/config.sub", './'
		system "#{HOMEBREW_PREFIX}/bin/autoconf"
		system 'sh', 'configure', "--prefix=#{prefix}"
		Dir.chdir('..')
		system 'make', 'prepare'
		system 'make', "darwin#{uname}/en/rs/fmsg_sfx.c" # fixme (issue around msg_arj.h error)
		system 'make', 'install'
	end
end
