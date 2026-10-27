# typed: true
# frozen_string_literal: true

# Gardenlogin is a formula for installing Gardenlogin
class Gardenlogin < Formula
  desc "Command-line tool for authenticating with Gardener clusters"
  homepage "https://gardener.cloud"
  version "0.11.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.11.0/gardenlogin_darwin_arm64"
      sha256 "22bc4bf8cff778ecc609a30d6541ee32ffeeb6c589476ce985f908d3dd4a8c47"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.11.0/gardenlogin_darwin_amd64"
      sha256 "435c8c609062ad3abf878ccf68630924c1c0bae7a8ea3c84a3e6754b91455788"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.11.0/gardenlogin_linux_arm64"
      sha256 "d4045657058416df249c7e498afd98c2607de1859383df2e269d1b1d46146b0e"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.11.0/gardenlogin_linux_amd64"
      sha256 "0d41150a4b7e119eea7954cc538faa8e453a8e076cc31bc446ea61bceea9339c"
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
