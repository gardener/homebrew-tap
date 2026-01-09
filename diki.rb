# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.24.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.24.0/diki-darwin-arm64"
      sha256 "9cc745b1efdcf7e6424c499bc9ed948ec79115590022313b36c9fbdd6df01eec"
    else
      url "https://github.com/gardener/diki/releases/download/v0.24.0/diki-darwin-amd64"
      sha256 "cef4644ebc433c7f07714e2721c16f67a1e79f6bcd78eb6dbf7649de559da037"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.24.0/diki-linux-arm64"
      sha256 "68096d95d2532476b2e8fcf5979bf19b492dfc5575832892fd972ce16b616c98"
    else
      url "https://github.com/gardener/diki/releases/download/v0.24.0/diki-linux-amd64"
      sha256 "97e809cd667fd36707fcdf950a67a6fba2857a7514bef982a1f5005a33f22b88"
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
