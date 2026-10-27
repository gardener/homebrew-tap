# typed: true
# frozen_string_literal: true

# GardenctlV2 is a formula for installing Gardenctl-v2
class GardenctlV2 < Formula
  desc "Command-line tool for managing Gardener clusters"
  homepage "https://gardener.cloud"
  version "2.18.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.18.0/gardenctl_v2_darwin_arm64"
      sha256 "7e88203b5560aa111b76b78b68ecb68017722303b214aaffaeef81be5b02887a"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.18.0/gardenctl_v2_darwin_amd64"
      sha256 "8fccb2c18dd27bfbcbb6bd34ed06c98fec5e366be67666e864656542286230ff"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.18.0/gardenctl_v2_linux_arm64"
      sha256 "545a6b0d4ba7fb43520a275dcba75ca8f0b50bdcbe1d21c780d14beaf4af6e41"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.18.0/gardenctl_v2_linux_amd64"
      sha256 "ae0e6f0964212668c85950eeb01be542ed22fe4a2be6b58762988a31b817ae69"
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
