# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.15.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.15.0/diki-darwin-arm64"
      sha256 "a6d018b30bc0c1f90cfe64c8812ba38855902915650308dc38b1c8fe98704a13"
    else
      url "https://github.com/gardener/diki/releases/download/v0.15.0/diki-darwin-amd64"
      sha256 "9877f114f5d60b75226e4161ca9f16364583dd16f5f2a7e164aaaab41550d22c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.15.0/diki-linux-arm64"
      sha256 "5d6d769c9c0b18fec13cca906ed1069d9c4e782de5f06832f10cb249f61b6a51"
    else
      url "https://github.com/gardener/diki/releases/download/v0.15.0/diki-linux-amd64"
      sha256 "5064b6dba8c4d3dd1b18a6b33ad1bf8f7fdbeff0eb2725af0ff5fdfe48ba92a4"
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
