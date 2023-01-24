class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v3.0.5"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.5/gardenlogin_darwin_arm64"
      sha256 "8edfc7325252212315dc1048d025d0bc3fe6c780094362cc149d43022cfc1cfd"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.5/gardenlogin_darwin_amd64"
      sha256 "7f0c61c2d008d2807532c97b33951695f5aa7a4f1c07d7cb231b2afb96925ccb"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v3.0.5/gardenlogin_linux_amd64"
    sha256 "5f6d68b04e43c2eab85d4048b6a0a1f1e8535c0f605a9490fb602d5d6201f785"
    depends_on :arch => :x86_64
  end

  def install
    bin.install stable.url.split("/")[-1] => "gardenlogin"
    bin.install_symlink bin/"gardenlogin" => "kubectl-gardenlogin"
  end

  test do
    system "#{bin}/gardenlogin", "version"
    system "#{bin}/kubectl-gardenlogin", "version"
  end
end

