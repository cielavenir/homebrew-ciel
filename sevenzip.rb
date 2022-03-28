require 'fileutils'

class Sevenzip < Formula
  desc "7-Zip is a file archiver with a high compression ratio"
  homepage "https://7-zip.org"
  url "https://7-zip.org/a/7z2107-src.tar.xz"
  version "21.07"
  sha256 "213d594407cb8efcba36610b152ca4921eda14163310b43903d13e68313e1e39"
  # head 'https://github.com/cielavenir/7-Zip-PKImplode.git', :revision => "4d5f9fa97e7c420c52a6c2df53665a4501222bd8"
  if respond_to? :license
    license all_of: ["LGPL-2.1-or-later", "BSD-3-Clause"]
  end

  conflicts_with "p7zip"

  if `uname`.chomp.end_with?('BSD')
    patch :p1 do
      url 'http://raw.githubusercontent.com/cielavenir/homebrew-ciel/master/patch/7z_freebsd.patch'
      sha256 '14db8f3832e93f0fc50dd950f460d80f9b0e55bbe52f3fafc3b0b3034db17d5e'
    end
  end

  def install
    [
      ["CPP/7zip/Bundles/Alone", "7za"],
      ["CPP/7zip/Bundles/Alone2", "7zz"],
      ["CPP/7zip/Bundles/Alone7z", "7zr"],
      ["CPP/7zip/Bundles/Format7zF", "7z.so"],
      ["CPP/7zip/UI/Console", "7z"],
      ["CPP/7zip/UI/Client7z", "7zcl"],
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
      (lib/"7-zip-full").install "#{make_dir}/b/#{directory}/#{prog}"
    end
    FileUtils.makedirs(bin)
    ["7za", "7zz", "7zr", "7z"].each{|prog| File.write(bin/prog,%Q(#!/bin/sh\nexec #{lib/"7-zip-full"/prog} "$@"\n)) }
  end

  test do
    (testpath/"foo.txt").write("hello world!\n")
    ["7za", "7zz", "7zr", "7z"].each do |prog|
      system bin/prog, "a", "-t7z", "foo.7z", "foo.txt"
      system bin/prog, "e", "-y", "foo.7z", "-oout"
      assert_equal "hello world!\n", (testpath/"out/foo.txt").read
    end
  end
end
