class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "v2.6.1"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.6.1/gardenctl_v2_darwin_arm64"
      sha256 "1b7b27a405292ab48863c13c3a1906d6a757dbb87798534b76de0548929ac009"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.6.1/gardenctl_v2_darwin_amd64"
      sha256 "5668aab3a9a7116c274639942cbb46442351376d52f6f6134d22904fb5b83ee9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.6.1/gardenctl_v2_linux_arm64"
      sha256 "9a96b9a63f199aa71307d26de8acbbe9cdae3bbc767a2dddaa62065388ad7a87"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.6.1/gardenctl_v2_linux_amd64"
      sha256 "3345ca44143d1af8b4ca6cdbff30ebf9204b7786e598daf2ff2e8d897519cbe3"
      depends_on :arch => :x86_64
    end
  end

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"

    print "\n[HINT]\n"
    print "  Consider to add the gardenctl startup script to your shell profile.\n"
    print "  It contains various tweaks, such as setting environment variables, loading completions and adding some helpful aliases or functions.\n"
    print "  Run `gardenctl rc --help` for more information.\n\n"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end

