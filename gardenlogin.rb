class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v0.2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.2.0/gardenlogin_darwin_arm64"
      sha256 "e6b7fe0079262f23724b20fe1441451261aa2b10ad867223ba0aae687abd3373"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.2.0/gardenlogin_darwin_amd64"
      sha256 "617dcfba7c1f540f93c59a0232c5974a351dc6c532100d5ff1a13b08fd2322ca"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v0.2.0/gardenlogin_linux_amd64"
    sha256 "51c0f325368f805ad2e6138e702032f2886c83d278c596e74059260a1efad016"
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

