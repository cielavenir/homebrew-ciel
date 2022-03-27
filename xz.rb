# Only for CentOS7.
# Without installing this brew cannot unpack tar.xz.

# Upstream project has requested we use a mirror as the main URL
# https://github.com/Homebrew/homebrew/pull/21419
class Xz < Formula
  desc "General-purpose data compression with high compression ratio"
  homepage "https://tukaani.org/xz/"
  url "https://downloads.sourceforge.net/project/lzmautils/xz-5.2.5.tar.gz"
  mirror "https://tukaani.org/xz/xz-5.2.5.tar.gz"
  sha256 "f6f4910fd033078738bd82bfba4f49219d03b17eb0794eb91efbae419f4aba10"
  license all_of: [
    :public_domain,
    "LGPL-2.1-or-later",
    "GPL-2.0-or-later",
    "GPL-3.0-or-later",
  ]

  # patch liblzma for CentOS7
  # https://stackoverflow.com/a/50518491
  patch :DATA

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

__END__
--- a/src/liblzma/liblzma.map 2015-09-29 12:57:36.000000000 +0200
+++ b/src/liblzma/liblzma.map 2017-02-22 11:10:33.432868185 +0100
@@ -95,7 +95,13 @@
 	lzma_vli_size;
 };
 
-XZ_5.2 {
+XZ_5.1.2alpha {
+global:
+	lzma_stream_encoder_mt;
+	lzma_stream_encoder_mt_memusage;
+} XZ_5.0;
+
+XZ_5.2.2 {
 global:
 	lzma_block_uncomp_encode;
 	lzma_cputhreads;
@@ -105,4 +111,4 @@
 
 local:
 	*;
-} XZ_5.0;
+} XZ_5.1.2alpha;
