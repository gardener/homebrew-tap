class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v3.0.8"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.8/gardenlogin_darwin_arm64"
      sha256 "ec5a92e3056fea702a257b6a0792f68282b0787ba1fd146b57c2548b5303701b"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.8/gardenlogin_darwin_amd64"
      sha256 "1eadbe1dac0dd7bcc9e32717dd8efb923e5f703459772479be27a493216be2fd"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v3.0.8/gardenlogin_linux_amd64"
    sha256 "2ce826ab2e71dd68c2d678ae9c4b0efefb93da9e90e82f82624abb5cdf23dc63"
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

