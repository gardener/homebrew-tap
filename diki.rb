# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.28.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.28.0/diki-darwin-arm64"
      sha256 "28ca16548b594d0eff2fb446745d9503c8c713690841a0d228c978aa929d5750"
    else
      url "https://github.com/gardener/diki/releases/download/v0.28.0/diki-darwin-amd64"
      sha256 "95cce25ecdbe87bb523b3bbee161b428f8ccd3b4127759c31458f80c07078a89"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.28.0/diki-linux-arm64"
      sha256 "ccd9a8f74939f6fbd48060b073f154de5645b928bf7e2d1359c5133d60ba1833"
    else
      url "https://github.com/gardener/diki/releases/download/v0.28.0/diki-linux-amd64"
      sha256 "f52307766f8640e46ec45435ba92d6f4887eb7a1bba6530bd1599d439cf7a53f"
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
