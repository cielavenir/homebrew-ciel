class Arj < Formula
	desc 'create and extract files from dos .arj archives'
	homepage 'http://arj.sourceforge.net/'
	url 'http://arj.sourceforge.net/files/arj-3.10.22.tar.gz'
	sha256 '589e4c9bccc8669e7b6d8d6fcd64e01f6a2c21fe10aad56a83304ecc3b96a7db'

	patch do
		url 'https://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/arj_debian.patch'
		sha256 '4b13cbad9139d5eaa2af562fdaed3efec97fbe80273b68e69f3069c9e8c701a4'
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
