class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "v0.24.3"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/v0.24.3/gardenctl-darwin-amd64"
    sha256 "84ea7726c91caad8d035bd4dbd67d546a0b4ae7ab2004f27dd8718d4ec9bfffa"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/v0.24.3/gardenctl-linux-amd64"
    sha256 "5a9a90a360726ead3c3f937ad27a2de50b6cdba2d3a97d3a536dbff4f8baed87"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"

    print "\n[WARNING]\n"
    print "  gardenctl is deprecated. Please install gardenctl-v2 instead.\n\n"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end

