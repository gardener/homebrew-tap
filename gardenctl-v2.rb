class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "v2.8.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.8.0/gardenctl_v2_darwin_arm64"
      sha256 "d7c05ed6abb6875b58de3e06a589d910060dcd5bd4f4b1aed919bcac04261000"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.8.0/gardenctl_v2_darwin_amd64"
      sha256 "b668cf1acd70351efc83e9b5c70c80127315099ce3c796978b7f301206054e84"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.8.0/gardenctl_v2_linux_arm64"
      sha256 "40b1f676cdc4314bca5a6a1475135d553bb4ef47d96f38629c658f694b440c21"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.8.0/gardenctl_v2_linux_amd64"
      sha256 "71758cee54dc6f8041cd3a59ea84bffff47c409ddddaad4f0059f86836d31fa8"
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

