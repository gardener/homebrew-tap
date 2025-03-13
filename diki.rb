# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.14.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.14.0/diki-darwin-arm64"
      sha256 "dc8279007a4a0b94910f09fa0ddc6c31fe7e9937ed1c8a662c1e1a299f3133e1"
    else
      url "https://github.com/gardener/diki/releases/download/v0.14.0/diki-darwin-amd64"
      sha256 "a48a27333cf267d555197c9a82ada46892a337d2dcf1c28bfd82f8f7da094844"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.14.0/diki-linux-arm64"
      sha256 "ba1f2ef571d423d0870c8586aeb3623f0d3cdf0a866b5bb86bd254c73d521c15"
    else
      url "https://github.com/gardener/diki/releases/download/v0.14.0/diki-linux-amd64"
      sha256 "9896a3975275041e7140b4b277d9d72f7f52bb3624a0aa5e2e8496adb3f4eda6"
      depends_on arch: :x86_64
    end
  end

  def install
    bin.install stable.url.split("/")[-1] => "diki"
  end

  def caveats
    <<~EOS
      [HINT]
      Run `diki view provider` to view supported providers and rulesets.
      Run `diki --help` for more information.
    EOS
  end

  test do
    system "#{bin}/diki", "version"
  end
end
