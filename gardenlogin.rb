# typed: true
# frozen_string_literal: true

# Gardenlogin is a formula for installing Gardenlogin
class Gardenlogin < Formula
  desc "Command-line tool for authenticating with Gardener clusters"
  homepage "https://gardener.cloud"
  version "0.8.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.8.0/gardenlogin_darwin_arm64"
      sha256 "776e41be9ef1ac94c57f6ba219bee3cf1f5a44a44ec0dda56270206bd640eb58"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.8.0/gardenlogin_darwin_amd64"
      sha256 "e90762c4b8605d9f9d99f87884dba2cd2c6aae35f6f1dd7a2a9d91810601ed89"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenlogin/releases/download/v0.8.0/gardenlogin_linux_arm64"
      sha256 "080d61f5257a943f17eef3ad39f320e3171907b4929a28b0dca51920f3816dba"
    else
      url "https://github.com/gardener/gardenlogin/releases/download/v0.8.0/gardenlogin_linux_amd64"
      sha256 "bb8dad63a648e771cb012fc35e207c570b4ec2f9378fcbe01a48251236e3c45e"
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
