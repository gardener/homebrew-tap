# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.21.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.21.1/diki-darwin-arm64"
      sha256 "483926fa38ea11ed32c90e3ce852a825419dc16e8fc0a17a46f8b418f6a08dc5"
    else
      url "https://github.com/gardener/diki/releases/download/v0.21.1/diki-darwin-amd64"
      sha256 "33ff2272b01e5f6aad1a460e8d2d956824fb38e7518824920b4a1006b9716c56"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.21.1/diki-linux-arm64"
      sha256 "5f7e1673f5565812fd267a287026080533741136143fa58deeeb99d7a0e7142d"
    else
      url "https://github.com/gardener/diki/releases/download/v0.21.1/diki-linux-amd64"
      sha256 "525689b8b49c8220c4a546dd8725f811ea1ca17ad28e8524a0cbaa94dc98ec98"
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
