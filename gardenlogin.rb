class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v3.0.13"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.13/gardenlogin_darwin_arm64"
      sha256 "56041dd13ac9adba242f455a2908dd52dc47fcdf3b12d3fcf2d07613f5d74e82"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.13/gardenlogin_darwin_amd64"
      sha256 "006b1c4ef766edc6d84bd2cfa8c6c068990c11e8eeb60f4c35cbdc3efd515dc1"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v3.0.13/gardenlogin_linux_amd64"
    sha256 "460f022981987c15ea8091e5a547607bd75b6beb81ac9917b8b9b06fb87626ea"
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

