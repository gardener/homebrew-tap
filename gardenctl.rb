class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "v0.17.0"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/v0.25.0/gardenctl-darwin-amd64"
    sha256 "9a179a17b17bce2094e115b685cfe6fdbce112ed"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/v0.25.0/gardenctl-linux-amd64"
    sha256 "9a179a17b17bce2094e115b685cfe6fdbce112ed"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end

