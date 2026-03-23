# typed: true
# frozen_string_literal: true

# Gardenlogin is a formula for installing Gardenlogin
class Gardenlogin < Formula
  desc "Command-line tool for authenticating with Gardener clusters"
  homepage "https://gardener.cloud"
  version "0.9.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.9.0/gardenlogin_darwin_arm64"
      sha256 "4bfb18de8783ba1c1ae80623092a49ef9add19428aa0b9fac219a51d35e6aaed"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.9.0/gardenlogin_darwin_amd64"
      sha256 "c72b555222b4361eaaaa37be64ea7c762265fd11b3b0e0bbed06f0b4d66cb08d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.9.0/gardenlogin_linux_arm64"
      sha256 "07cc2ab5ae310dfd25279169f55d7fba4427992d875cd86d6f35e03c0d93445f"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.9.0/gardenlogin_linux_amd64"
      sha256 "2fdb1afc37d5f1e00b91e1bd4f2168a199ac5c0f16bac43a87e98150eedb06b6"
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
