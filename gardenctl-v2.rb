# typed: true
# frozen_string_literal: true

# GardenctlV2 is a formula for installing Gardenctl-v2
class GardenctlV2 < Formula
  desc "Command-line tool for managing Gardener clusters"
  homepage "https://gardener.cloud"
  version "2.10.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.10.0/gardenctl_v2_darwin_arm64"
      sha256 "1396927742dc0f469c3f3c80847920f3b4ab88511e26ae62ec840dd4f14c2c5f"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.10.0/gardenctl_v2_darwin_amd64"
      sha256 "126148f3da4337197f9e2ac12f4139b68766f33cf484b796134613b44344f08e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.10.0/gardenctl_v2_linux_arm64"
      sha256 "20f1b9e339bbc25737bd4b81ed6227999b67c04816de1c60a71cea1d58dfa84b"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.10.0/gardenctl_v2_linux_amd64"
      sha256 "87b2c35c828c3d2b40ff02ddf5eae7f6c92e3d2ec8016249d2b122a6a73a43cb"
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
