# typed: true
# frozen_string_literal: true

# Diki is a formula for installing Diki
class Diki < Formula
  desc "Command-line tool for compliance checks"
  homepage "https://gardener.cloud"
  version "0.15.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.15.1/diki-darwin-arm64"
      sha256 "a514901b9a521e7b72365418b418895a082077b8e06723c3f7bcc0f6501858d5"
    else
      url "https://github.com/gardener/diki/releases/download/v0.15.1/diki-darwin-amd64"
      sha256 "583d03c9ec0890efe05a77c8c5727a3e888142704d6e86e91995cc2ad012d6a0"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/diki/releases/download/v0.15.1/diki-linux-arm64"
      sha256 "49ce96ec6709293fa77e436faa61600e4e7597880ac6b6b261e7a0cb3226f183"
    else
      url "https://github.com/gardener/diki/releases/download/v0.15.1/diki-linux-amd64"
      sha256 "f414c1b2dda894d125781d35db6983cf8b5116eb5e33fb70b8a7b866a496e55b"
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
