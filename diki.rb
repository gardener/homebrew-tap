# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.29.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.29.0/diki-darwin-arm64"
      sha256 "63cf2ca3a134365d1ff2eba9ebe20f5c8bd6578b5ea4f92aa070b8654f9f8675"
    else
      url "https://github.com/gardener/diki/releases/download/v0.29.0/diki-darwin-amd64"
      sha256 "c082af83b31fc8730a291341955bf0d13846e0a97c36741f7d830fba5eb93ee5"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.29.0/diki-linux-arm64"
      sha256 "bcb93c852cc9294b58a9665be9c99ee2f50521a6f45f8b45c15c5944ab227703"
    else
      url "https://github.com/gardener/diki/releases/download/v0.29.0/diki-linux-amd64"
      sha256 "f272cdbd42ce8ccbd2f7498e763b750ac01ba863d0e87bf738898c254b7a252a"
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
