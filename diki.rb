# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.25.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.25.0/diki-darwin-arm64"
      sha256 "b10259bce9af82e644b4fd7cabc63bb1208d907a7ad80ab6f3d297e0986e3434"
    else
      url "https://github.com/gardener/diki/releases/download/v0.25.0/diki-darwin-amd64"
      sha256 "8a3bfbff119a0096014f78bbf48358de417097465df86fe080990a74d0110f1d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.25.0/diki-linux-arm64"
      sha256 "7f318135a1060f7aa2abae21759688651f09660fa47489e2b05b5a75b466edc0"
    else
      url "https://github.com/gardener/diki/releases/download/v0.25.0/diki-linux-amd64"
      sha256 "596c4fbedfa380539d7106adde111598d4d4a6cca5bf575e35d529a93a442c69"
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
