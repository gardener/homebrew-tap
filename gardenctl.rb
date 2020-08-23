class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "v0.20.0"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/v0.19.0/gardenctl-darwin-amd64"
    sha256 "24e86671a6f500e76c2ea4156e49b59cb478e459aad8593ac502ee1bcfdc99b3"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/v0.19.0/gardenctl-linux-amd64"
    sha256 "4f0ab767ac75f13469cfce44972905fbe860b8c30fdc2cfd747187a7b1ca8c49"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end
