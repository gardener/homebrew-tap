class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "v0.23.0"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/v0.23.0/gardenctl-darwin-amd64"
    sha256 "4dfb90eba3d39e6b2d43a1b837e438aaabc2c6a9f7d27de72f5b62258007219c"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/v0.23.0/gardenctl-linux-amd64"
    sha256 "e033065a4e54830004c9c0d6bc1f7d063aa1baa78eae2ddbb7a13600219e811e"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end

