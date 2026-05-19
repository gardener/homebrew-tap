# typed: true
# frozen_string_literal: true

# Gardenlogin is a formula for installing Gardenlogin
class Gardenlogin < Formula
  desc "Command-line tool for authenticating with Gardener clusters"
  homepage "https://gardener.cloud"
  version "0.10.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.10.0/gardenlogin_darwin_arm64"
      sha256 "fe4f2b8bc52787f2f59f8ee23ce05b2890de3cd5f1e2f73eef516c81d59c6d1c"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.10.0/gardenlogin_darwin_amd64"
      sha256 "db4206c260dceff8284b0dfe98618f89904241b6a0e78684d3185491d79732e8"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.10.0/gardenlogin_linux_arm64"
      sha256 "d641a80f1b9094beb8ce31fcb96f5777ace3757d5bf39e3f43ae6ed0a2aa04b6"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.10.0/gardenlogin_linux_amd64"
      sha256 "5f89c7899dbd31b9e1c6fff09720fa3f15f52b1cda5f6476ecdeccbaefe09c7f"
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
