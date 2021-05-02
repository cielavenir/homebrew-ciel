# homebrew-ciel

Ciel's homebrew formulae

gdc on macOS: gcc 11 supports gdc officially. please copy attic/gcc.rb to /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/ .

## patch

- gen_debian.rb
    - A script to generate a single patch file from debian directory.

- arj_debian.patch
- arj_makefile_port.patch
- twintail.patch
- twintail_disablenet.patch
- unace_debian.patch
- unace_unincore.patch
    - Used in my formulae.

- io.patch
    - https://github.com/Homebrew/formula-patches/pull/71 (Already resolved)
- rust.patch
    - Done in upstream.

## sakura

- Some supplement files for sakura-server (FreeBSD).
- https://qiita.com/cielavenir/items/67ce0ec9cd8d43ed00f1

## waifu2x

|formula|command|
|:--|:--|
|waifu2x-deadsix27|waifu2x-converter-cpp|
|waifu2x-ueshita|waifu2x-converter-glsl|
|waifu2x-yui0|waifu2x_glsl|
|imxieyi/waifu2x/waifu2x|waifu2x|
