# Only for CentOS7.
# Without installing this, brew cannot unpack tar.xz internally.

# Upstream project has requested we use a mirror as the main URL
# https://github.com/Homebrew/homebrew/pull/21419
class Xz < Formula
  desc "General-purpose data compression with high compression ratio"
  homepage "https://tukaani.org/xz/"
  url "https://downloads.sourceforge.net/project/lzmautils/xz-5.2.5.tar.gz"
  mirror "https://tukaani.org/xz/xz-5.2.5.tar.gz"
  sha256 "f6f4910fd033078738bd82bfba4f49219d03b17eb0794eb91efbae419f4aba10"
  if respond_to?(:license)
    license all_of: [
      :public_domain,
      "LGPL-2.1-or-later",
      "GPL-2.0-or-later",
      "GPL-3.0-or-later",
    ]
  end

  # patch liblzma for CentOS7
  # https://stackoverflow.com/a/50518491
  if `uname -r`.include?('.el7.')  # todo better check
    patch :p1 do
      url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/xz_centos7.patch'
      sha256 '0a65a3eb48ac42ed3a8d60079c1423465002b73bd2d89c55dd512c5c84381e38'
    end
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "check"
    system "make", "install"
  end

  test do
    path = testpath/"data.txt"
    original_contents = "." * 1000
    path.write original_contents

    # compress: data.txt -> data.txt.xz
    system bin/"xz", path
    refute_predicate path, :exist?

    # decompress: data.txt.xz -> data.txt
    system bin/"xz", "-d", "#{path}.xz"
    assert_equal original_contents, path.read
  end
end
