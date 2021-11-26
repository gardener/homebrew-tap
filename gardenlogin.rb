class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v0.1.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.1.2/gardenlogin_darwin_arm64"
      sha256 "5c209d0296c66f6334fe83fc29db0c58c210707344a2b1381325cee8dc5e499a"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.1.2/gardenlogin_darwin_amd64"
      sha256 "db7c7808e568febfda817b9df689e74a31f0b51d06078024b6dfdf876f38e9ec"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v0.1.2/gardenlogin_linux_amd64"
    sha256 "bbecd0c01a7b170bac4dbaf1846f8f7f8f54bdb94457a9bdfd5fc9e8abfa8b3a"
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

