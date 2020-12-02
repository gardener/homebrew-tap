class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "v0.24.0"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/v0.24.0/gardenctl-darwin-amd64"
    sha256 "8f7c9c8f2cdfb34b4a17bb540a921729dc69cc4d230ae673d11d8c98c5b2c5c0"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/v0.24.0/gardenctl-linux-amd64"
    sha256 "616383077e3039c9932f6baeea6efaaa7763d0232f0646135c34a723f26302e2"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end

