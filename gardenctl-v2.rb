class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "v2.6.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.6.0/gardenctl_v2_darwin_arm64"
      sha256 "93ddb1da1bb8a2e7fd51730eff1d015cd677030ada99a14b2c76f1bb7cae87a1"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.6.0/gardenctl_v2_darwin_amd64"
      sha256 "bd649821becc0036674445bedeef5fc1af11ff13ccb848057353f2b3654884a7"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.6.0/gardenctl_v2_linux_arm64"
      sha256 "96a33f319bce95e65b23c0cba52a4c45ecdddf437256de7af7c03493609a495a"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.6.0/gardenctl_v2_linux_amd64"
      sha256 "f1043d031c6bdf9588729506870ece9d732ccb984514ce2d43802317423381dd"
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

