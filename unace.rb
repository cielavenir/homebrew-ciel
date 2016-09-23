class Unace < Formula
	desc 'extract files from .ace archives'
	homepage 'http://www.winace.com/'
	url 'http://archive.ubuntu.com/ubuntu/pool/multiverse/u/unace-nonfree/unace-nonfree_2.5.orig.tar.gz'
	sha256 '5a85480ed0d39672962a05dc835efc0876be4f0d47b0fa7741b955ae7b148566'

	patch do
		url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/unace_debian.patch'
		sha256 '7eb6459b89db63bdb65145644a096c5eb5e639407a1063673cbdda5225bd477a'
	end
	patch do
		url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/unace_unincore.patch'
		sha256 'fec3097205d6c955d6007eb864db071d1d490c0e3120abec99573344825a5b42'
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
