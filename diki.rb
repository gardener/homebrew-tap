# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.21.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.21.0/diki-darwin-arm64"
      sha256 "fc4500fbf845e383f78890f9576d128fa64fb1096ce6ac0cc8387b0bd0a031e6"
    else
      url "https://github.com/gardener/diki/releases/download/v0.21.0/diki-darwin-amd64"
      sha256 "ae110ab56cdc6ea591d9aa5ccca4684f7c2baa1357cdb5760db1d9dbff48c913"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.21.0/diki-linux-arm64"
      sha256 "1b263b78b17cf3e2e23e07ead2bc6a186b7ed0bc8135820c6d17ba154c777a50"
    else
      url "https://github.com/gardener/diki/releases/download/v0.21.0/diki-linux-amd64"
      sha256 "4dee0dc96f609a683ed5d203692308969c85a849e7f3d922f1afc6f0e4644aa9"
      depends_on arch: :x86_64
    end
  end

  def install
    bin.install stable.url.split("/")[-1] => "diki"
  end

  def caveats
    <<~EOS
      [HINT]
      Run `diki --help` for more information or find out more at https://github.com/gardener/diki.
    EOS
  end

  test do
    system "#{bin}/diki", "version"
  end
end
