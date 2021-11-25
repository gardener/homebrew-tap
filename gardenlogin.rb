class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v0.1.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.1.0/gardenlogin_darwin_arm64"
      sha256 "39287ff7c13f88a5e9266f4b33519bde1ca914df974002f08f3535bb9f5b3c15"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.1.0/gardenlogin_darwin_amd64"
      sha256 "f1f632c19c94cc23138c1f1d97c64c2fe198092a83e8ae95ec6d6cd8f615f4c4"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v0.1.0/gardenlogin_linux_amd64"
    sha256 "7547e86450628348515e287289d3f553577c747f7a538f8cfea5d4efb643df02"
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

