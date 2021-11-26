class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v0.1.4"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.1.4/gardenlogin_darwin_arm64"
      sha256 "2cd575cdbb870c0b9930525db9a9429f619440fa9d1205504626cb83fd05fca2"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.1.4/gardenlogin_darwin_amd64"
      sha256 "c13d87c928f0dd10715fdeb409ce4cc8ba018b64fec1c2cff641e056cf1cc908"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v0.1.4/gardenlogin_linux_amd64"
    sha256 "efa9a39f9b640a5108bdfefae1ff2ed3c6d7139fcee8338169ae9b6b15c845dc"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenlogin"
    bin.install_symlink bin/"gardenlogin" => "kubectl-gardenlogin"
  end

  test do
    system "#{bin}/gardenlogin", "version"
    system "#{bin}/kubectl-gardenlogin", "version"
  end
end

