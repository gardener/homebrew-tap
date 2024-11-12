# typed: true
# frozen_string_literal: true

# Gardenlogin is a formula for installing Gardenlogin
class Gardenlogin < Formula
  desc "Command-line tool for authenticating with Gardener clusters"
  homepage "https://gardener.cloud"
  version "0.6.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.6.0/gardenlogin_darwin_arm64"
      sha256 "d5f84338063e92593bc296a6181d6332588f35132b2b63bcd2523343ae298da8"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.6.0/gardenlogin_darwin_amd64"
      sha256 "344f96f8845f6dd2bae3e953d0e7162fa2fd6098ff01bc2c28068043f8676d10"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.6.0/gardenlogin_linux_arm64"
      sha256 "3c932458c884824698597a8b5edad059854ce391d69b85c693b102a965093e81"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.6.0/gardenlogin_linux_amd64"
      sha256 "87894a729675dcedadc241be6ad52e0244e70000b180516c5d9198e0f726b9d7"
      depends_on arch: :x86_64
    end
  end

  def install
    bin.install stable.url.split("/")[-1] => "gardenlogin"
    bin.install_symlink bin/"gardenlogin" => "kubectl-gardenlogin"
  end

  def caveats
    <<~EOS
      If you are using an OIDC kubeconfig, you may need to install 'kubelogin'.
      You can install it manually by running:
        brew install int128/kubelogin/kubelogin
    EOS
  end

  test do
    system "#{bin}/gardenlogin", "version"
    system "#{bin}/kubectl-gardenlogin", "version"
  end
end
