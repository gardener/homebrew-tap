# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.27.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.27.0/diki-darwin-arm64"
      sha256 "87c2cbbb551bc5c849a76eafbb2edb4aec9d2d00cf84dc382e204663dcf7dc38"
    else
      url "https://github.com/gardener/diki/releases/download/v0.27.0/diki-darwin-amd64"
      sha256 "9b1b1b948bb08004faba64c6ad5fe4138f6c7a6a62f970b9be131e82d1a724c0"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.27.0/diki-linux-arm64"
      sha256 "c6b733dd0f8fe532ebd656c5b1c72a595aa5684eeba14075b5c67ac183c6c68b"
    else
      url "https://github.com/gardener/diki/releases/download/v0.27.0/diki-linux-amd64"
      sha256 "778c3a19ddf52140c5217b9d1d1173b247c6dbce74e638f01f7b615805a1bda4"
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
