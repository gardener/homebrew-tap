# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.26.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.26.0/diki-darwin-arm64"
      sha256 "26efc60b1408049da21bca8cec863c00fc159e6270ee3f7f1926c39304a16385"
    else
      url "https://github.com/gardener/diki/releases/download/v0.26.0/diki-darwin-amd64"
      sha256 "b72988bcf210eb9e97ff615c60421e16feaa09c2235ef20e41dcb0702a08163b"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.26.0/diki-linux-arm64"
      sha256 "6c87a26daa35ef077c9600e84519b4b7ac35a9d5eb03acfe53c5e1ee1b9ff13d"
    else
      url "https://github.com/gardener/diki/releases/download/v0.26.0/diki-linux-amd64"
      sha256 "16c804d6a9adb980d6cba24ac6118d27ba5d5f4f43a654c8309316e4137ac7e5"
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
