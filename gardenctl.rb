class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "v0.18.0"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/v0.18.0/gardenctl-darwin-amd64"
    sha256 "a4d9cc3eacbf239b99dcb3514715d4a9339768350d7d990bdc00ff23fd312e64"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/v0.18.0/gardenctl-linux-amd64"
    sha256 "36d5c1ee451c3d06d70e65e6c70e5bad05ca84ee515708c50e3195fe67aff1e0"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end
