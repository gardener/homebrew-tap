class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "v3.0.9"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.9/gardenlogin_darwin_arm64"
      sha256 "dd7534e77ef31cb29ece93307d9f77fe0a0401bd3edd478be36cf91fb3651b06"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v3.0.9/gardenlogin_darwin_amd64"
      sha256 "f7ffa255abc066990dbbe69b7d4ea28b4168b33b415ce17be4fb25ca00489790"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/v3.0.9/gardenlogin_linux_amd64"
    sha256 "8b7e95a8861444e59304c5130f2ed92827c893d5ae67ce85e8e233fc2a669500"
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

