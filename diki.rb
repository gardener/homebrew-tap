# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.17.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.17.0/diki-darwin-arm64"
      sha256 "bc47642c874187217d9f673809c9db4f417776c7d1692e370d54034aa9067a3a"
    else
      url "https://github.com/gardener/diki/releases/download/v0.17.0/diki-darwin-amd64"
      sha256 "f72bf85953758ab38a384085c34c83eca045ace7275b3838aa761e49e79f2dd4"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.17.0/diki-linux-arm64"
      sha256 "b2f39b4082841e6a5d60383ec89284f73eadc6aedf0da98fbc0ad82ca1fa039c"
    else
      url "https://github.com/gardener/diki/releases/download/v0.17.0/diki-linux-amd64"
      sha256 "f3e686b6fc3330f3c52c4d8a0245b46b6682c85e32fddb3a0eed5e7dc4a53ac9"
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
