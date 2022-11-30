class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "v2.1.1"

  depends_on "gardener/tap/gardenlogin"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.1.1/gardenctl_v2_darwin_arm64"
      sha256 "e387f80c783062c23acef30000ef7bdfc534c93844d2d1719b83be6572d4bfbd"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.1.1/gardenctl_v2_darwin_amd64"
      sha256 "80a7f3fed0cef950d9cae02afb8c1668854ce8df2cb150f945558d47953c367f"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl-v2/releases/download/v2.1.1/gardenctl_v2_linux_amd64"
    sha256 "9275ee86e6fa011f0f64f620f997f2f17331c915426397e19133205bd26939c5"
    depends_on :arch => :x86_64
  end

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end

