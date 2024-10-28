# typed: true
# frozen_string_literal: true

# Gardenlogin is a formula for installing Gardenlogin
class Gardenlogin < Formula
  desc "Command-line tool for authenticating with Gardener clusters"
  homepage "https://gardener.cloud"
  version "v0.5.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.5.1/gardenlogin_darwin_arm64"
      sha256 "fda9e6c360ac347174534dbb3017972f74e895921afee08993665028515c9e06"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.5.1/gardenlogin_darwin_amd64"
      sha256 "12238fa41e5d175bee2d119cb3edcdb5b1b48e7c79d8921110e7c0a5b742f9c4"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.5.1/gardenlogin_linux_arm64"
      sha256 "da8607ad96f35c06618a911d150eeb2bf9e20025a0e191d613a6484d1b93258e"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.5.1/gardenlogin_linux_amd64"
      sha256 "dd53c642d49d6285b199f34053943d84c13013d31d84542ad6d1c5309dc63eac"
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

