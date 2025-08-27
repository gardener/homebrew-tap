# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.19.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.19.1/diki-darwin-arm64"
      sha256 "b0fbf7c144bfbb7b26024185880979b93fc78168aa17273b361cb937fcb65275"
    else
      url "https://github.com/gardener/diki/releases/download/v0.19.1/diki-darwin-amd64"
      sha256 "a7d48078075f77723da0d5cbd404a3e22b19490fb100d79f79d565c04ddae437"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.19.1/diki-linux-arm64"
      sha256 "525e05bd0a4ac9b6c016996b4da0ae2f2ecc7dc4c6f3788e645e38360a6cec42"
    else
      url "https://github.com/gardener/diki/releases/download/v0.19.1/diki-linux-amd64"
      sha256 "42bdd644e0425be27d95992576127c2e581f9f5a6e31b69e489680a4d6d83961"
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
