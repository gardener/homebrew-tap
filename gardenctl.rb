class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "v0.23.1"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/v0.23.1/gardenctl-darwin-amd64"
    sha256 "81cb57c307d53a737e86aebb0b969c9b147ccd0f8fb5409ff9dedd28390b6b6f"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/v0.23.1/gardenctl-linux-amd64"
    sha256 "1b4482627970153c653e87b338472466b4440d63b432a38a1079003f59e1799c"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end

