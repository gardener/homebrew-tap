class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "v2.4.0"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.4.0/gardenctl_v2_darwin_arm64"
      sha256 "9d1b6548a7773ba10763fd3bda6c25295b68c84723e8303b4803cdd4daf35fe3"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.4.0/gardenctl_v2_darwin_amd64"
      sha256 "198c3e81ab03682cb4abb6239e0d7a3bfd448ecf4e8cb9432136287592bd8d36"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl-v2/releases/download/v2.4.0/gardenctl_v2_linux_amd64"
    sha256 "476c3f6c86f21f8fed2f1e45f6f9103c6cab11328231b18317fad3d0cb30a8b3"
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

