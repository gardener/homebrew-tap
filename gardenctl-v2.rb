class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "v2.5.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.5.0/gardenctl_v2_darwin_arm64"
      sha256 "0a6a259e9ba2c53298100c250e211e79a69d730f938d71f5355245fbc2b64be0"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.5.0/gardenctl_v2_darwin_amd64"
      sha256 "1af223a094bc893bdb0774371c2449ba69b1852a3500e270c8f91d1702fc564e"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl-v2/releases/download/v2.5.0/gardenctl_v2_linux_amd64"
    sha256 "635f71e33af8d9418ced115ddaa4ca5aa6187614d4ef3ef766603b37e7d748da"
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

