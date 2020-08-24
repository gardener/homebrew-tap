class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "v0.21.0"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/v0.19.0/gardenctl-darwin-amd64"
    sha256 "7b27b54cb14420bc44fe02c08f1b451f10fb4cd8dd266b414e80c8d9b5f5b286"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/v0.19.0/gardenctl-linux-amd64"
    sha256 "32ceb64608523dc166ce9aa0d89c1c4ee299920cf99e0bfe4953a7c12594e524"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end
