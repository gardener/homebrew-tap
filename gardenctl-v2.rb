# typed: true
# frozen_string_literal: true

# GardenctlV2 is a formula for installing Gardenctl-v2
class GardenctlV2 < Formula
  desc "Command-line tool for managing Gardener clusters"
  homepage "https://gardener.cloud"
  version "2.12.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.12.0/gardenctl_v2_darwin_arm64"
      sha256 "039419f914de746af3cf5d6ecac0083d4a31a74fe4f651514859ed34005f588b"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.12.0/gardenctl_v2_darwin_amd64"
      sha256 "2e9b2696a1d20af341fe579693c1e3b55d0b4c4aad07efb2b5c1beb89180b546"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.12.0/gardenctl_v2_linux_arm64"
      sha256 "a4e54584261a0a432d3da6d479d90b068805d3544dd30dde294d47430d2576b5"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.12.0/gardenctl_v2_linux_amd64"
      sha256 "8552532041d44080534c5f421ad111bef9aa45b2da3c4db51857c1b852f2aef9"
      depends_on arch: :x86_64
    end
  end

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  def caveats
    <<~EOS
      [HINT]
      Consider adding the gardenctl startup script to your shell profile.
      It contains various tweaks, such as setting environment variables,
      loading completions, and adding some helpful aliases or functions.
      Run `gardenctl rc --help` for more information.
    EOS
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end
