class Autoconf < Formula
  desc "Automatic configure script builder"
  homepage "https://www.gnu.org/software/autoconf"
  url "https://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz"
  mirror "https://ftpmirror.gnu.org/autoconf/autoconf-2.69.tar.gz"
  sha256 "954bd69b391edc12d6a4a51a2dd1476543da5c6bbf05a95b59dc0dd6fd4c2969"
  revision 1 unless OS.mac?

  unless OS.mac?
    # Fix configure: error: no acceptable m4 could be found in $PATH.
    depends_on "m4"

    # For autom4te.
    # Don't use system perl since autoconf requires Data/Dumper.pm which may not
    # be installed. https://github.com/Linuxbrew/homebrew-core/issues/7522
    #depends_on "perl"
  end

  def install
    ENV["PERL"] = "/usr/bin/perl" if OS.mac?

    # force autoreconf to look for and use our glibtoolize
    inreplace "bin/autoreconf.in", "libtoolize", "glibtoolize"
    # also touch the man page so that it isn't rebuilt
    inreplace "man/autoreconf.1", "libtoolize", "glibtoolize"

    system "./configure", "--prefix=#{prefix}", "--with-lispdir=#{elisp}"
    system "make", "install"

    rm_f info/"standards.info"
  end

  test do
    cp pkgshare/"autotest/autotest.m4", "autotest.m4"
    system bin/"autoconf", "autotest.m4"
  end
end
