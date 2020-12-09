class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "v0.24.1"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/v0.24.1/gardenctl-darwin-amd64"
    sha256 "4cf612529150712e53a7d52ee2286caa8bbd92c382912cdfa4d0e9e07c70702d"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/v0.24.1/gardenctl-linux-amd64"
    sha256 "3ef93148aa21eb4f3bad449a30bf8b404c973b3515ba9ebc8964e67148297993"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end

