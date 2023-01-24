class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v3.0.6"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.6/gardenlogin_darwin_arm64"
      sha256 "cc3153e1ffba1d4c3d94472bd87ba19b96e7c804e942dc70be99f8b2f119a93a"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.6/gardenlogin_darwin_amd64"
      sha256 "85f21e505d7a51ff0bd8b94dc04dbc84e05dbe33d6791bfc4875240fe8936e47"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v3.0.6/gardenlogin_linux_amd64"
    sha256 "3d0952d27258cb1a9571faf7911e824607571276dab8947580cd691f2a28e431"
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

