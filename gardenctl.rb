class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "v0.24.2"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/v0.24.2/gardenctl-darwin-amd64"
    sha256 "0015c11559a727b38dc29aa3e9eeb9196b5434dce18965e00a3189e6e07f6635"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/v0.24.2/gardenctl-linux-amd64"
    sha256 "89d1dc908e342854154b70ccc42107c092dfd586ad982048e9ab4e9e878efcaa"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end

