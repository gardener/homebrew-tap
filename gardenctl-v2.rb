# typed: true
# frozen_string_literal: true

# GardenctlV2 is a formula for installing Gardenctl-v2
class GardenctlV2 < Formula
  desc "Command-line tool for managing Gardener clusters"
  homepage "https://gardener.cloud"
  version "2.14.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.14.0/gardenctl_v2_darwin_arm64"
      sha256 "ab5ebe0066b41f5a29a147680101dcc6df8c4cad9f2afb2abc8dd1b65cf1cc55"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.14.0/gardenctl_v2_darwin_amd64"
      sha256 "eb741bfeb36d496c38200439980d8595c0e8dd46198fcf8c2b17f29939d7b14d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.14.0/gardenctl_v2_linux_arm64"
      sha256 "4d6fde45c42235ba9fc4012a1ecf349b501f260f97bb08ceb6152d08228186cc"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.14.0/gardenctl_v2_linux_amd64"
      sha256 "2426747892e061b77664c0825859615f8bce8472992f8d284766b7119de2e10f"
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
