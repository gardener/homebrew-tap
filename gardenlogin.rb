class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v0.1.3"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.1.3/gardenlogin_darwin_arm64"
      sha256 "91cb953863ed3f4d34ce5526d98039466e79d9172c8f64c95d99ca4161cbf8ff"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.1.3/gardenlogin_darwin_amd64"
      sha256 "80226cdc570808c19fd4288af28b81df1b9fbcdffb6d8db8a112ae0daaecb142"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v0.1.3/gardenlogin_linux_amd64"
    sha256 "6914308786e65faa14ed7e9cd21e787db44f39094105086ebdb24d90a15b2f8f"
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

