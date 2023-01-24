class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v3.0.4"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.4/gardenlogin_darwin_arm64"
      sha256 "6b625dce5f212fc35635e7ce55c4cb36f6630f382e6e1906b59e4423b3aba5da"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.4/gardenlogin_darwin_amd64"
      sha256 "f7ef75fd7fd5c134c68bcd0e226a66c38fd5b7c06773daf7f66d5bf86ff2bfcd"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v3.0.4/gardenlogin_linux_amd64"
    sha256 "f551a3fb8580d2779f63eb6d7682c36be6378b8275e3eff19af5a84d7b35a50e"
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

