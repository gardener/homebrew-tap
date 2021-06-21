class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "1.12.0"

  if OS.mac?
    url "https://github.com/gardener/gardenlogin/releases/download/1.12.0/gardenlogin-darwin-amd64"
    sha256 "d1c90a2910a08b766fbd72a18d1f0f099b69377555f0c7a13d93c31812941261"
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/1.12.0/gardenlogin-linux-amd64"
    sha256 "4e640e0e4198abbe6cd9798d4c4c24c7d3ea0fc27e4319d2b6793ca8e8779caf"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenlogin"
  end

  test do
    system "#{bin}/gardenlogin", "version"
  end
end

