class Unace < Formula
	desc 'extract files from .ace archives'
	homepage 'http://www.winace.com/'
	url 'http://archive.ubuntu.com/ubuntu/pool/multiverse/u/unace-nonfree/unace-nonfree_2.5.orig.tar.gz'
	sha256 '5a85480ed0d39672962a05dc835efc0876be4f0d47b0fa7741b955ae7b148566'

	patch do
		url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/unace_debian.patch'
		sha256 '1dfe8c1f9b3f82776733d8661813e8a9bb8b0237b140505109d1a7f31afe355f'
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
