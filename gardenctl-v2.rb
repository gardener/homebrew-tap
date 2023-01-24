class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version ".latest_release_filtered_tag"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/.latest_release_filtered_tag/gardenctl_v2_darwin_arm64"
      sha256 "b1bcd6c0d2a779266d248729a009d4907c11e0b3cb0ad7465ebbd628c55548b8"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/.latest_release_filtered_tag/gardenctl_v2_darwin_amd64"
      sha256 "887edb99da17bc755d89607a866107742b1eebc595cb7f974f00f51bf8862f21"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl-v2/releases/download/.latest_release_filtered_tag/gardenctl_v2_linux_amd64"
    sha256 "25ffbd8b06bb6bdc25aa01e164aaa2e178d696980f9412b096c7bbb41d0e398c"
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

