# typed: true
# frozen_string_literal: true

# Gardenlogin is a formula for installing Gardenlogin
class Gardenlogin < Formula
  desc "Command-line tool for authenticating with Gardener clusters"
  homepage "https://gardener.cloud"
  version "0.7.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.7.0/gardenlogin_darwin_arm64"
      sha256 "a0b06860cc2006372d518a3fb7a52492e5d2e0a7df82fe5924dd4f20d77a145a"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.7.0/gardenlogin_darwin_amd64"
      sha256 "b0cc338442fc9b5ddcd9d8f30812bd37d5aaf17765d7e8f49bcb4984ade63260"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.7.0/gardenlogin_linux_arm64"
      sha256 "bacff868a584af6a8112aad941750a7bb5831b7ceda80c9dd3301383b7293bd4"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.7.0/gardenlogin_linux_amd64"
      sha256 "39fdea5cab5935865f8aacb4a5bb637fdf712e3af9226cb0611cc06260d4f824"
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
