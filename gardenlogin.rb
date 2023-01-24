class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v3.0.7"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.7/gardenlogin_darwin_arm64"
      sha256 "cc28838f1e5b2ca630b2cfa2cc27e6935f6c30cc7db883ad572148894abc40ac"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.7/gardenlogin_darwin_amd64"
      sha256 "9b3152cbdb2016f017987115d28c5d445bd1f6bed41e98a565a50d3e7794cfe4"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v3.0.7/gardenlogin_linux_amd64"
    sha256 "4ad3ec284b90739781f7ecbeefbcebd19351309a214e8a8aefb29bd6a6727fa3"
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

