# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.19.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.19.0/diki-darwin-arm64"
      sha256 "75bdb677bc8e7c3ac005eacef42c0347acde910f431954006df0d870be8188d6"
    else
      url "https://github.com/gardener/diki/releases/download/v0.19.0/diki-darwin-amd64"
      sha256 "5418f23098bdb8834d93ce1b3a3e3d7012c61018bb7d9bbd94d1c7df9b8cd3d8"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.19.0/diki-linux-arm64"
      sha256 "1dd52121486703b9296152fdacd74d733d39a3c5e61d13e1a1284faa409f1959"
    else
      url "https://github.com/gardener/diki/releases/download/v0.19.0/diki-linux-amd64"
      sha256 "53016a27fe61caf4a97b9b3f07eb157b8910a0310b846f1c87d47caf67ad63d4"
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
