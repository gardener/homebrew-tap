# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.23.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.23.0/diki-darwin-arm64"
      sha256 "203d8865562c72584c9f67ea62bbeb93c4014b1d508146662d3307ef922db6c0"
    else
      url "https://github.com/gardener/diki/releases/download/v0.23.0/diki-darwin-amd64"
      sha256 "bc0f7a2d49fa81dcc444f4674e939c76f87e3ea0b46fe7e5d770fb3850a2cc92"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.23.0/diki-linux-arm64"
      sha256 "925e2d7fa941e77d0f46b580b49e3817d1f02b1e0d0a4f0d7ad25989a73171ba"
    else
      url "https://github.com/gardener/diki/releases/download/v0.23.0/diki-linux-amd64"
      sha256 "e69cce2c807a6692bcfeb3dd787df23b51848f67161de919fa45dd0f16481724"
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
