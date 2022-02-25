class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "v2.0.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.0.0/gardenctl_v2_darwin_arm64"
      sha256 "6e436eeac47b2569b57e7d23531230bcc3bf5ecbfb411d7b4612124735cbbaf3"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.0.0/gardenctl_v2_darwin_amd64"
      sha256 "66a136887e85b7bdd152aaeaa65c6e03092c51599baf19fa66eafe9ca498fb51"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl-v2/releases/download/v2.0.0/gardenctl_v2_linux_amd64"
    sha256 "85d728ab5653553e7243f8fd7955ff5d4502b9b79a8a6ea24440d62ebd9b1228"
    depends_on :arch => :x86_64
  end

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end

