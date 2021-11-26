class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v0.1.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.1.1/gardenlogin_darwin_arm64"
      sha256 "affd5f0ddcf38df9ecbc497b4b5624c15874ba26e832205429e5a4a9cdc00347"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.1.1/gardenlogin_darwin_amd64"
      sha256 "37f0db9b6d4de61ba7f5bf6f7baa7ed11b89752c225230b1f2afa6c00193642c"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v0.1.1/gardenlogin_linux_amd64"
    sha256 "0880e357b087b8af640e4c531a0152176f09a1e551cacd3190397333a825f2fa"
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

