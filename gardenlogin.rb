class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v0.1.5"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.1.5/gardenlogin_darwin_arm64"
      sha256 "7e2631f1701ad6053e1bfaab1af5df9a6c4f09978dc2c6fd26a6d92210ab8483"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.1.5/gardenlogin_darwin_amd64"
      sha256 "b76678514d96b960fe4adeaf64d901f89b4c32ef574eaa1368938462bfbabee2"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v0.1.5/gardenlogin_linux_amd64"
    sha256 "a51fbd6e5885ecd32c9b52ef05ff082521288431e4339858c10277c0b8e2ad37"
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

