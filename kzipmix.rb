# https://github.com/jonof/homebrew-kenutils/blob/master/Formula/kzipmix.rb adapted for Linuxbrew

class Kzipmix < Formula
    desc "Ken Silverman's ZIP file optimisation utilities"
    homepage "https://www.jonof.id.au/kenutils"

    version = "20200115"
    if `uname`.chomp.end_with?('BSD')
        url "https://www.jonof.id.au/files/kenutils/kzipmix-#{version}-bsd.tar.gz"
        sha256 "9763f45305c31e3a9a06bb1a15178251726115fffe71dd5fef178932764ffe63"
        @@archdir = 'amd64/'
    elsif OS.linux?
        url "https://www.jonof.id.au/files/kenutils/kzipmix-#{version}-linux.tar.gz"
        sha256 "78f8327b40fafc40f9df3c7ac5f7cb9d88648de77b48f53804b39942bf44df20"
        @@archdir = 'amd64/' # 'aarch64/'
    else
        url "https://www.jonof.id.au/files/kenutils/kzipmix-#{version}-macos.zip"
        sha256 "0013ad12ee9676552dc28b900d94066132586e68cc236f9e9c38e0f18968e102"
        @@archdir = ''
    end

    def install
        mkdir_p "#{prefix}/bin"
        cp @@archdir+"kzip", "#{prefix}/bin/kzip"
        cp @@archdir+"zipmix", "#{prefix}/bin/zipmix"
    end
end
