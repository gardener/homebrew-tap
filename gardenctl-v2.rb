# typed: true
# frozen_string_literal: true

# GardenctlV2 is a formula for installing Gardenctl-v2
class GardenctlV2 < Formula
  desc "Command-line tool for managing Gardener clusters"
  homepage "https://gardener.cloud"
  version "2.15.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.15.0/gardenctl_v2_darwin_arm64"
      sha256 "87f72c7d4fa04939a84062bf7f45c3fb4858160bd0233af3022f95c75aada5df"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.15.0/gardenctl_v2_darwin_amd64"
      sha256 "c4fb148e50565031f5cbc3dd011a963f3271dd0789afbd2e714d07815c602c10"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.15.0/gardenctl_v2_linux_arm64"
      sha256 "840e8e004ea9ca1fc3d86620e5399de496956c4324e45bb34d8e424cd849832e"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.15.0/gardenctl_v2_linux_amd64"
      sha256 "e5fa24f82d93573b4a05d57ff024e6436de3861c434e2961607eab91c83eca42"
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
