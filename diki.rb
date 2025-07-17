# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.18.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.18.0/diki-darwin-arm64"
      sha256 "0ccfa4a6dc5386503109bfeab3350b570997a6cf17985e4fc640c9d15c72969e"
    else
      url "https://github.com/gardener/diki/releases/download/v0.18.0/diki-darwin-amd64"
      sha256 "15bd7b9a9a570f5d6f7fa6d8736bf5c2cf7d192865f912364aa42a0935572837"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.18.0/diki-linux-arm64"
      sha256 "2aad5b1570504beaf1626214fe2f8ad33234914dd653d5cc57fa306f0f454e82"
    else
      url "https://github.com/gardener/diki/releases/download/v0.18.0/diki-linux-amd64"
      sha256 "ff83cdf1e26b6d716f571fc11d6d391bc93078dedd29fb2efa5f69e0aee9ae00"
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
