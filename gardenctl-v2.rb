class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "v2.2.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.2.0/gardenctl_v2_darwin_arm64"
      sha256 "b961c5d52865c938ad4f9e1cd53b659f731edbd4bb72d17a80d3bccaf7825507"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.2.0/gardenctl_v2_darwin_amd64"
      sha256 "dadcffc96a84b0d2cda936044b9ec74c27a002a288a76d0eb7644f4fa18bd50b"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl-v2/releases/download/v2.2.0/gardenctl_v2_linux_amd64"
    sha256 "d3d0fb33b8581eaad4a9f3216c3567cd0ae2fee47ae19cf9b22025bc993b4291"
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

