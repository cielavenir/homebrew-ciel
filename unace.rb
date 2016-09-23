class Unace < Formula
	desc 'extract files from .ace archives'
	homepage 'http://www.winace.com/'
	url 'http://archive.ubuntu.com/ubuntu/pool/multiverse/u/unace-nonfree/unace-nonfree_2.5.orig.tar.gz'
	sha256 '5a85480ed0d39672962a05dc835efc0876be4f0d47b0fa7741b955ae7b148566'

	patch do
		url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/unace_debian.patch'
		sha256 'f855f7ad4d11aaa92d9c26431630dc463f826394dba8ae80737105a9849203f4'
	end
	patch :p0 do
		url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/unace_unincore.patch'
		sha256 '35d534d45d88d55c0384f3e588318ab322ba9d240bd5ac37dc8e259e90c1d311'
	end
	patch :p0 do
		url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/unace_memory.patch'
		sha256 '71d2c99e308337cbadc24ceb7dd19971d3b946e638cd88bb938e78e0484b4569'
	end

	def install
		system 'make'
		system 'cp', 'unace', prefix
	end
end
