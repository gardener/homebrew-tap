# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.30.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.30.0/diki-darwin-arm64"
      sha256 "77f729dcde978910f89b966131ae1edb035ceb0714de72716772fdc5eeb739cf"
    else
      url "https://github.com/gardener/diki/releases/download/v0.30.0/diki-darwin-amd64"
      sha256 "6723625c5d54b204b6b99ef05361dc95a081d18190c0c00ae1df03815a5e7dd9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.30.0/diki-linux-arm64"
      sha256 "ca18532a42f30631066a63937ffac9d6c96f0f46cd6726bc95f9236e454ba0e4"
    else
      url "https://github.com/gardener/diki/releases/download/v0.30.0/diki-linux-amd64"
      sha256 "91f62544e6c7617b24cb22bce1816a7265d0beb3105bf4daf0b4bfaa816f0620"
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
