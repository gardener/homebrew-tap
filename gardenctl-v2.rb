# typed: true
# frozen_string_literal: true

# GardenctlV2 is a formula for installing Gardenctl-v2
class GardenctlV2 < Formula
  desc "Command-line tool for managing Gardener clusters"
  homepage "https://gardener.cloud"
  version "2.16.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.16.0/gardenctl_v2_darwin_arm64"
      sha256 "011528834f967ae8eb0f378bb112cb0531503f4d836fa763a26a83cac8f2e83d"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.16.0/gardenctl_v2_darwin_amd64"
      sha256 "78c76acd8116bc708cddc03896feb13ae229387ab842619f1a5b45d6715db6a6"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.16.0/gardenctl_v2_linux_arm64"
      sha256 "c45f77f1a220a958623ec2d94d8da5db0144f34fb0cf6ed82de66fe85c3f6fea"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.16.0/gardenctl_v2_linux_amd64"
      sha256 "3ee53cdc95e501f5dfba894261519cc6a6055a1fdd8e2e7ddc29b404bffa3e83"
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
