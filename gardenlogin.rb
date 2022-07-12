class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v0.3.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.3.0/gardenlogin_darwin_arm64"
      sha256 "9292eb7d4ad9b274ab51dd771c32d0b018ed5e2b2430b359908fda467912346d"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.3.0/gardenlogin_darwin_amd64"
      sha256 "15c5398c66c91f8e7e7bd59de5d9db3678c03835e88cd0d8f0e37ed45297b96c"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v0.3.0/gardenlogin_linux_amd64"
    sha256 "e1a62ed867aba3f5b0b55987a9a1457586936ea7e0a3cb061229c41873d08c60"
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

