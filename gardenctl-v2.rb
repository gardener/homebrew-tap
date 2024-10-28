# typed: true
# frozen_string_literal: true

# GardenctlV2 is a formula for installing Gardenctl-v2
class GardenctlV2 < Formula
  desc "Command-line tool for managing Gardener clusters"
  homepage "https://gardener.cloud"
  version "2.9.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.9.0/gardenctl_v2_darwin_arm64"
      sha256 "ac44451dc8a8128d03da9d9598863b9f190c225844a67b59ec16e2c6208374b8"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.9.0/gardenctl_v2_darwin_amd64"
      sha256 "4b82f8da2f6c383ac035527777bda399dbd8b66e5f0a2ca7a2c2e59f354e2318"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.9.0/gardenctl_v2_linux_arm64"
      sha256 "2594bbb42e4d593d79dda901af298bf12cc653d0ed8cee17e7d0bf1379ef8a5f"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.9.0/gardenctl_v2_linux_amd64"
      sha256 "78a26f0aad25ff8e8e231dfa20031146bfa82062ee8d81b6c3141af7d60b5413"
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
