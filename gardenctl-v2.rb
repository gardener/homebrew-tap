class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "v2.3.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.3.0/gardenctl_v2_darwin_arm64"
      sha256 "9e2a8b4daf8b7bb4b0ce17ef82eba0d00d3470e53ad051f3d17dc3426746c210"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.3.0/gardenctl_v2_darwin_amd64"
      sha256 "0ddb23619cf302736c3e5751cc63f3c29d020e1623659392d84faad1ab3e0423"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl-v2/releases/download/v2.3.0/gardenctl_v2_linux_amd64"
    sha256 "5782e71ae3dbfd7aefde86e7d61f041aa1f9deca315b6849998fbae67ecee65e"
    depends_on :arch => :x86_64
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

