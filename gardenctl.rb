class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "v0.19.0"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/v0.19.0/gardenctl-darwin-amd64"
    sha256 "cfd74b1007baf974aed905255bc188ae3af87124a5ead50eb6b04c88ff73a7ab"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/v0.19.0/gardenctl-linux-amd64"
    sha256 "45b8681b365a6322da3dafff83f513075675046d63bf574852d60c8b924ba540"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end
