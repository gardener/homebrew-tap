# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.27.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.27.1/diki-darwin-arm64"
      sha256 "e0ffa56684ad0f59f9102e442165a84d2c6ccb4099bf34f1d073e3e275773303"
    else
      url "https://github.com/gardener/diki/releases/download/v0.27.1/diki-darwin-amd64"
      sha256 "7ca418d7b756de2bd0f1edfb02f5b06f6710c43f1dc9fadffdb9be917d8d5938"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.27.1/diki-linux-arm64"
      sha256 "fd5c7caa80a818649ea47425a1a214a44e3c1b59220e9ca8c04fcae6fa3b065d"
    else
      url "https://github.com/gardener/diki/releases/download/v0.27.1/diki-linux-amd64"
      sha256 "2a73d35e6db66b28626153afa78e7b6e6e1b72bdd88f4cec4ae05b53a2731900"
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
