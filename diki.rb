# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.16.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.16.0/diki-darwin-arm64"
      sha256 "56b22986df115da9a3cf578cb84115c50452d1f0c01ca974f0a39ccb30ce8170"
    else
      url "https://github.com/gardener/diki/releases/download/v0.16.0/diki-darwin-amd64"
      sha256 "1c52bde461c211fc9ba631ead5da3fba013713f175f6540f6418e7b66491108d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.16.0/diki-linux-arm64"
      sha256 "bd64e0dd0ab38145c94848d213e49529651e02862c804b5509649dced5098cd4"
    else
      url "https://github.com/gardener/diki/releases/download/v0.16.0/diki-linux-amd64"
      sha256 "058ecdf29aa87673f6df8efb4772de3b999b52a5f34e979574c331d4711e6dca"
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
