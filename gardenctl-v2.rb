class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "v2.2.1"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.2.1/gardenctl_v2_darwin_arm64"
      sha256 "721b8923ac2138189a5b91612400ac8500b77c703e1c0d448f68a11fc6e4024c"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.2.1/gardenctl_v2_darwin_amd64"
      sha256 "357f24487f32924b4c0923e53fbf8c8aedf48b1007bddf1b55776b5729d93d5a"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl-v2/releases/download/v2.2.1/gardenctl_v2_linux_amd64"
    sha256 "52921ccd618d76efdd0f7b804d1bf246dd964518205a6e1172c23b68a6cc285d"
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

