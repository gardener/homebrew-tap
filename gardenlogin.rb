class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v3.0.10"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.10/gardenlogin_darwin_arm64"
      sha256 "f282d2bb825feeca7635760950aa3b687e7e71fedd5bfda4ebde6b6aed56baf6"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.10/gardenlogin_darwin_amd64"
      sha256 "4688b4fb4d91571af6b936ed348b7b39ace08f4cd463e19dae965c22df2bb825"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v3.0.10/gardenlogin_linux_amd64"
    sha256 "fcfc6deb6cdcca2130002b3d6081e25418a8caf1a06932ce19669903dfabd143"
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

