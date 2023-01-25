class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "v3.0.11"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v3.0.11/gardenctl_v2_darwin_arm64"
      sha256 "abc"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v3.0.11/gardenctl_v2_darwin_amd64"
      sha256 "abc"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl-v2/releases/download/v3.0.11/gardenctl_v2_linux_amd64"
    sha256 "anc"
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

