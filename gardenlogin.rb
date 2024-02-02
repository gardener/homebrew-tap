class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v0.5.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.5.0/gardenlogin_darwin_arm64"
      sha256 "8a780f46662c170da7aa4ac0da2fdb3f4b0ee106b3147c03da716d2dc5b69894"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.5.0/gardenlogin_darwin_amd64"
      sha256 "6a79d897ff2978c0ee6acb6c797bed8829bb0fe536d4cb6d45343263f67c6e5f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.5.0/gardenlogin_linux_arm64"
      sha256 "62d2c295b35a391521ab72e0fd4cb7041142f187608fb64795837958e2cd28ff"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.5.0/gardenlogin_linux_amd64"
      sha256 "074cc068d59a6e24bdf5a907f539a02d44d5889bfee3767055ba2e6cd0dcd872"
      depends_on :arch => :x86_64
    end
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

