class Vlang < Formula
  desc "V programming language"
  homepage "https://vlang.io"
  version "0.2.1"
  url "https://github.com/vlang/v/archive/0.2.1.tar.gz"
  sha256 "0e7d37e7ef7a5001b86811239770bd3bc13949a6489e0de87b59d9e50ea342c9"
  
  def install
    system 'make'
    libexec.install "v","vlib","examples","thirdparty","cmd","v.mod"
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

    FileUtils.cp_r(libexec/"v",testpath)
    FileUtils.cp_r(libexec/"v.mod",testpath)
    FileUtils.cp_r(libexec/"cmd",testpath)
    FileUtils.cp_r(libexec/"vlib",testpath)
    FileUtils.cp_r(libexec/"thirdparty",testpath)
    # https://github.com/vlang/v/issues/2176 does not resolve that we need to copy all files to testpath
    shell_output("#{testpath}/v test #{testpath}/")
  end
end
