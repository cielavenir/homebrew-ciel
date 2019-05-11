class Arj < Formula
	desc 'create and extract files from dos .arj archives'
	homepage 'http://arj.sourceforge.net/'
	url 'http://arj.sourceforge.net/files/arj-3.10.22.tar.gz'
	sha256 '589e4c9bccc8669e7b6d8d6fcd64e01f6a2c21fe10aad56a83304ecc3b96a7db'

	depends_on 'autoconf' => :build

	patch :p0 do
		url 'https://trac.macports.org/export/153066/trunk/dports/archivers/arj/files/patch-environ.c'
		sha256 '5bdce32f97f061114e781b0cfa05b748a3bada2e251b9f2a827c94ab0b60f813'
	end
	patch :p0 do
		url 'https://trac.macports.org/export/153066/trunk/dports/archivers/arj/files/patch-postproc.c'
		sha256 '318a17fe3df478f6ba01be4863174b8c63a45d027f263f23b6e97474832d5d67'
	end
	patch :p0 do
		url 'https://trac.macports.org/export/153066/trunk/dports/archivers/arj/files/patch-uxspec.c'
		sha256 'a4a332c9e7015f9b32f3bcc73966653dcbe606ec8e44e7d6fb08216aae828eee'
	end

	patch do
		url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/arj_debian.patch'
		sha256 '4b13cbad9139d5eaa2af562fdaed3efec97fbe80273b68e69f3069c9e8c701a4'
	end
	patch :p0 do
		url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/arj_makefile_port.patch'
		sha256 '0e9484a06ef1275ae78e86feb952fc4511aa5cd08adeaf434de33c200a28055e'
	end

	bottle do
		root_url "https://dl.bintray.com/cielavenir/homebrew"
		sha256 "bde513c232f1ec16d85370368e8f768986513b9c5ca5635a3124108b2e289e99" => :sierra
	end

	def install
		Dir.chdir('gnu')
		system 'cp', "#{HOMEBREW_PREFIX}/share/libtool/build-aux/config.guess", './'
		system 'cp', "#{HOMEBREW_PREFIX}/share/libtool/build-aux/config.sub", './'
		system "#{HOMEBREW_PREFIX}/bin/autoconf"
		system 'sh', 'configure', "--prefix=#{prefix}"
		Dir.chdir('..')
		system 'make', 'install'
	end
end

__END__
cd gnu
cp /usr/local/share/libtool/build-aux/config.guess ./
cp /usr/local/share/libtool/build-aux/config.sub ./
/usr/local/bin/autoconf
sh configure
cd ..
make
