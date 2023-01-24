class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "v3.0.8"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v3.0.8/gardenctl_v2_darwin_arm64"
      sha256 "4642f5117d5bf2b5da481330e7d1d75c2cfb537a2e9c46d40f9206c0ea0ee645"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v3.0.8/gardenctl_v2_darwin_amd64"
      sha256 "543e8c8e34d2db5060ee3ac1b82ea468ebd64cb26dc60d196b294c8444b9e2e6"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl-v2/releases/download/v3.0.8/gardenctl_v2_linux_amd64"
    sha256 "58dc9858f6ea87d976781d48be70b469a1a2d73652a4688289509dff60d40c91"
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

