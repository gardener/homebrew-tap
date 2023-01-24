class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v3.0.14"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.14/gardenlogin_darwin_arm64"
      sha256 "e32e7ee3072f6c28b431be039172d2e1bb3a5f67d114666ca296a9dc3635e8d8"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.14/gardenlogin_darwin_amd64"
      sha256 "6535c96aa5dfc416d641294e7bcde112ad2b0b01cc025350f596df113e990b9d"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v3.0.14/gardenlogin_linux_amd64"
    sha256 "bff0c6922e79b3d8f31e73ceaf151f8e592652d6440097a121841eb9f5cddc57"
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

