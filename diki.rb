# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.22.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.22.0/diki-darwin-arm64"
      sha256 "2cc691db4d686afa1bee93cf6d93889b6dcabfd66d618792bedead8cca78a318"
    else
      url "https://github.com/gardener/diki/releases/download/v0.22.0/diki-darwin-amd64"
      sha256 "0f03902f49a4444fb95028dd992f4a76a17844ee2813be4129778995d96cc1e3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.22.0/diki-linux-arm64"
      sha256 "f1bec3eeed557e715e7282799bb329c4d74f9773192850bfcb36189c772b5176"
    else
      url "https://github.com/gardener/diki/releases/download/v0.22.0/diki-linux-amd64"
      sha256 "9426746b94e1f013f1ca89c765c449a8988821116ff7497d3a81b89beeb4e476"
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
