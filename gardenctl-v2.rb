# typed: true
# frozen_string_literal: true

# GardenctlV2 is a formula for installing Gardenctl-v2
class GardenctlV2 < Formula
  desc "Command-line tool for managing Gardener clusters"
  homepage "https://gardener.cloud"
  version "2.19.1"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.19.1/gardenctl_v2_darwin_arm64"
      sha256 "2dac4aa190a68e4cea4f0279e2081ca3a3e0fe1bec2a4e47a767248b3562aff3"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.19.1/gardenctl_v2_darwin_amd64"
      sha256 "34b0d634b5212ba8a954134898a7f25de4294b868452dbc24cfaf1faa88a4a97"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.19.1/gardenctl_v2_linux_arm64"
      sha256 "7df8c7ff54e98350fca4b19b0daa6354d96c04b82b63fd2a57e5e0bf8de68c24"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.19.1/gardenctl_v2_linux_amd64"
      sha256 "b8f7153988f6e9fc75723d8afca124b1f3998e45ad56b5d64123ce0996c9ea4c"
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
