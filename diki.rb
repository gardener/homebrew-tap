# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.20.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.20.0/diki-darwin-arm64"
      sha256 "5daa6173a08e74f88d5833e7f3ac0f8c38ef8f7d56b05c0f26df954402fd3edd"
    else
      url "https://github.com/gardener/diki/releases/download/v0.20.0/diki-darwin-amd64"
      sha256 "4dd41133cfa93a3cb4f2e053131bab4e79f4187dadda55c1f7b82535028d5afd"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.20.0/diki-linux-arm64"
      sha256 "27e83a69904e263c4c1c89cea3a76d460b2c230398410660b5f6698979bd55cb"
    else
      url "https://github.com/gardener/diki/releases/download/v0.20.0/diki-linux-amd64"
      sha256 "bee15ecae4b14ef32731b58d246462b24818cb4824fa22d995a8a7e27779678b"
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
