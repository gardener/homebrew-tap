class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "v2.7.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.7.0/gardenctl_v2_darwin_arm64"
      sha256 "b895b5d1dca8bad1497500c3531d81e1a6bec3de7ae8ada7f6b4c18712deea28"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.7.0/gardenctl_v2_darwin_amd64"
      sha256 "ec2473360fd9e09622f241820f2816718cc681c2187f35b95c8e1d08539475df"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.7.0/gardenctl_v2_linux_arm64"
      sha256 "5e2e38a42d7e77596a3fc4489002265619402480a0f668d5c4872da2cd64bb04"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.7.0/gardenctl_v2_linux_amd64"
      sha256 "38dc04e53f9f67904d31e6c7e4c35c1b4c3829260d9efdf5ea6845f6611a5773"
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

