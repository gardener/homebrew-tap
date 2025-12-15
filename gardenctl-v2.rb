# typed: true
# frozen_string_literal: true

# GardenctlV2 is a formula for installing Gardenctl-v2
class GardenctlV2 < Formula
  desc "Command-line tool for managing Gardener clusters"
  homepage "https://gardener.cloud"
  version "2.13.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.13.0/gardenctl_v2_darwin_arm64"
      sha256 "46632041c3e22abb6dd8074bb14524520110205f1126c96b187e6c20b9cc9fa2"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.13.0/gardenctl_v2_darwin_amd64"
      sha256 "74d0f95a60e3a285e35bfa633f7f7674a22d75aa972f3a1abdc400b665f6848a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.13.0/gardenctl_v2_linux_arm64"
      sha256 "ff75c348a86c488cb76e23a51d984034379e92bcaf54b24d95f66754451e75f6"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.13.0/gardenctl_v2_linux_amd64"
      sha256 "3627837835ecba58f50555f9429d52e4f9964da913913eb9db95a945ef5d578b"
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
