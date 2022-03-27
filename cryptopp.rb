# mirror of https://github.com/Homebrew/homebrew-core/blob/1e214c2396abaa959f90333d97f31138708e84b6/Formula/cryptopp.rb

class Cryptopp < Formula
  desc "Free C++ class library of cryptographic schemes"
  homepage "https://www.cryptopp.com/"
  url "https://github.com/weidai11/cryptopp/archive/CRYPTOPP_8_6_0.tar.gz"
  sha256 "9304625f4767a13e0a5f26d0f019d78cf9375604a33e5391c3bf2e81399dfeb8"
  license "BSD-3-Clause"

  # https://cryptopp.com/wiki/Config.h#Options_and_Defines
  # bottle :disable, "Library and clients must be built on the same microarchitecture"

  def install
    system "make", "shared", "all", "CXX=#{ENV.cxx}"
    system "./cryptest.exe", "v"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <cryptopp/sha.h>
      #include <string>
      using namespace CryptoPP;
      using namespace std;

      int main()
      {
        byte digest[SHA1::DIGESTSIZE];
        string data = "Hello World!";
        SHA1().CalculateDigest(digest, (byte*) data.c_str(), data.length());
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lcryptopp", "-o", "test"
    system "./test"
  end
end
