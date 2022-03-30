# https://github.com/jonof/homebrew-kenutils/blob/master/Formula/pngout.rb adapted for Linuxbrew

class Pngout < Formula
    desc "Ken Silverman's PNG optimisation utility"
    homepage "https://www.jonof.id.au/kenutils"

    version = "20200115"
    if `uname`.chomp.end_with?('BSD')
        url "https://www.jonof.id.au/files/kenutils/pngout-#{version}-bsd.tar.gz"
        sha256 "69565ec27c7290ca3729beeac1757baa6758afbb659ceb431e4cb1432a2308c7"
        @@archdir = 'amd64/'
    elsif OS.linux?
        url "https://www.jonof.id.au/files/kenutils/pngout-#{version}-linux.tar.gz"
        sha256 "ac38bba6f0de29033de866538c3afa64341319b695bbe388efbc5fd9e830e928"
        @@archdir = 'amd64/' # 'aarch64/'
    else
        url "https://www.jonof.id.au/files/kenutils/pngout-#{version}-macos.zip"
        sha256 "3272fa947eeafc1ac0086e1f14935f9efa21d090a555e6892255fe5c88f6686e"
        @@archdir = ''
    end

    def install
        mkdir_p "#{prefix}/bin"
        cp @@archdir+"pngout", "#{prefix}/bin/pngout"
    end
end
