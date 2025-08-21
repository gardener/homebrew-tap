# typed: true
# frozen_string_literal: true

# Gardenlogin is a formula for installing Gardenlogin
class Gardenlogin < Formula
  desc "Command-line tool for authenticating with Gardener clusters"
  homepage "https://gardener.cloud"
  version "0.7.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.7.1/gardenlogin_darwin_arm64"
      sha256 "bcbc2dd2eeface439e3e459482dea355cc6548925747836442960ae0141f6c58"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.7.1/gardenlogin_darwin_amd64"
      sha256 "fa3ba5e18a82644b4f0f11f26912db367c5f58abaebbfd5e1255d64bb1b17faf"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.7.1/gardenlogin_linux_arm64"
      sha256 "dcb3a5f2aad41f97e98b7b8b1e55a6c4e2faf3cb7440a910643e711b3c6d8f84"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.7.1/gardenlogin_linux_amd64"
      sha256 "f5ad55e523570cac47ab52b41a4d5d276ad9cdef3c82b05a67ad20536a2694f2"
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
