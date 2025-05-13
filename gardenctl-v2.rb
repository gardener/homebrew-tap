# typed: true
# frozen_string_literal: true

# GardenctlV2 is a formula for installing Gardenctl-v2
class GardenctlV2 < Formula
  desc "Command-line tool for managing Gardener clusters"
  homepage "https://gardener.cloud"
  version "2.11.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.11.0/gardenctl_v2_darwin_arm64"
      sha256 "9b5fbd93e9f033015dfe0b34014972da12649ef9149ced947a5440adfd3acadb"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.11.0/gardenctl_v2_darwin_amd64"
      sha256 "70e9e0b79bc1b4a4aaee2bcb6efc276033247903b47f6f41affcddff010ea332"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.11.0/gardenctl_v2_linux_arm64"
      sha256 "18cbbfff3722bcd14234a8c7bab8b285a79de5f916a44e2b41ee5935386dfa53"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.11.0/gardenctl_v2_linux_amd64"
      sha256 "4f07bf8f9d5618bfff5e3d2ad9d30aadb78e8192f3b4f283c89d4ab7f281d3e4"
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
