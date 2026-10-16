# typed: true
# frozen_string_literal: true

# GardenctlV2 is a formula for installing Gardenctl-v2
class GardenctlV2 < Formula
  desc "Command-line tool for managing Gardener clusters"
  homepage "https://gardener.cloud"
  version "2.17.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.17.0/gardenctl_v2_darwin_arm64"
      sha256 "64a3595f826e15675fac372cccd0747da25cfcd2b906cb8ab1883dd0d17afed4"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.17.0/gardenctl_v2_darwin_amd64"
      sha256 "1ebadaef2b94853a8703759a59f77b914dc4da7adf0f6f74f0f7b765f3fae613"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.17.0/gardenctl_v2_linux_arm64"
      sha256 "5d75451dbe7162dd882ff2bf727ffd19d9a0c298c18f86b1fc7ecd762050e97b"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.17.0/gardenctl_v2_linux_amd64"
      sha256 "94da5b7a0122705721619fe626067f3ec9fd9a2fe48f279c4acd7d6b26ba90e5"
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
