class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "v0.17.0"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/v0.17.0/gardenctl-darwin-amd64"
    sha256 "ca6ec9804432a36e45e30bf5fd903c68cef3574062fb9bac6eb80a557d863486"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/v0.17.0/gardenctl-linux-amd64"
    sha256 "8d33c751e8d32fe7fff15306c7de59cf15c45fb04e2f9abf988d3edd3f305cc4"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end
