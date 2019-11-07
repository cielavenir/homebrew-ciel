class Vlang < Formula
  desc "V programming language"
  homepage "https://vlang.io"
  url "https://github.com/vlang/v/archive/33b5afa.tar.gz"
  sha256 "f0479782e90bbe00db3902e22403292d81a013805c8a346cb9b833b9d409257e"

  resource "vc" do
    url "https://github.com/vlang/vc/archive/2b1f494.tar.gz"
    sha256 "f380c3198b912c3ae800daadfeb7ad2985d1be9692ac50c6f311079779f6ccd4"
  end
  
  def install
    resource("vc").stage do
      system ENV.cc,"-std=gnu11","-w","-o","v","v.c","-lm"
      libexec.install "v"
    end
    libexec.install "vlib","examples","thirdparty","tools"
    bin.install_symlink libexec/"v"
  end

  test do
    (testpath/"hello-v.v").write <<~EOS
      fn main() {
        println('Hello, world!')
      }
    EOS
    system "#{bin}/v", "-o", "hello-v", "hello-v.v"
    assert_equal "Hello, world!\n", `./hello-v`

    #need https://github.com/vlang/v/commit/fa7e0ce58a731d393e633b68a0710c7d1e27543f to be released
    #shell_output("#{bin}/v test v")
  end
end

__END__
0.1.20 79a98d7 6a2f0a5
0.1.21 5ac62bb 950a90b
0.1.22 33b5afa 2b1f494
