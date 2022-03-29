# to use this Rar.so, /usr/local/opt/lib/7-zip-full/7z must be called by full-path, not practical...

require_relative 'sevenzip'

class SevenzipRar < Sevenzip
  @stable = Sevenzip.stable

  if respond_to? :license
    license :cannot_represent
  end

  patch :p1 do
    url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/7z_rar.patch'
    sha256 '6a3cd625417e8637edf3fd4d5ca48babdecc2146424083437d0f2e8adf7e883e'
  end

  def install
    [
      ["CPP/7zip/Compress/Rar", "Rar.so"],
    ].each do |make_dir, prog|
      mac_suffix = Hardware::CPU.intel? ? "x64" : Hardware::CPU.arch
      mk_suffix, directory = if OS.mac?
        ["mac_#{mac_suffix}", "m_#{mac_suffix}"]
      else
        ["gcc", "g"]
      end

      system "make", "-C", make_dir, "-f", "../../cmpl_#{mk_suffix}.mak"

      # Cherry pick the binary manually. This should be changed to something
      # like `make install' if the upstream adds an install target.
      # See: https://sourceforge.net/p/sevenzip/discussion/45797/thread/1d5b04f2f1/

      # I use "7-zip-full" to make it similar to https://aur.archlinux.org/packages/7-zip-full
      (lib/"7-zip-full"/"Codecs").install "#{make_dir}/b/#{directory}/#{prog}"
    end
  end
end
