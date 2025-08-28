# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.19.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.19.2/diki-darwin-arm64"
      sha256 "89689841708c398dfbe910f3c7a02a7f07261b88c6f74a07eb8fea8ead635919"
    else
      url "https://github.com/gardener/diki/releases/download/v0.19.2/diki-darwin-amd64"
      sha256 "e27ba56c9bfb9c79dc27974ef178eb865f4b92c30b56057933e317004f341bb4"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.19.2/diki-linux-arm64"
      sha256 "78cfbd0d419cd507ced704744f6b5494c5604bb99198b0c898dfe8eef1638e9b"
    else
      url "https://github.com/gardener/diki/releases/download/v0.19.2/diki-linux-amd64"
      sha256 "ae6a4f0fe2cfda04c05895431b7980d98565ab4bee32f2f3c0bc485f64c14c2b"
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
