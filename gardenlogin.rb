class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v0.4.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.4.0/gardenlogin_darwin_arm64"
      sha256 "1b5966e20beab00d81734a2af0e5893f8121e4e46a9bfd8463d9d3525b216d31"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.4.0/gardenlogin_darwin_amd64"
      sha256 "21e5835e4c22dc9255dfb769fb2fe760f260eeb1db04961fb8f8b2e1cf948b7c"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v0.4.0/gardenlogin_linux_amd64"
    sha256 "4a9bcf1641453dfc6ddd712cbd96deb0ab859ac1261c06f18a472922c1e4228b"
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

