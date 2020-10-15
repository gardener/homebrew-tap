class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "v0.22.0"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/v0.22.0/gardenctl-darwin-amd64"
    sha256 "d761188b6cc4be328f070d765cc8b37c49e01c3b45fa98fbb6b4835c2e36d5f2"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/v0.22.0/gardenctl-linux-amd64"
    sha256 "afcf3b5c6cf89b74ea936d5888d3be11dbba6c738c52b06433a3ee8f1aa6cd70"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end

