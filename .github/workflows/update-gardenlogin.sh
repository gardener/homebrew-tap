#!/usr/bin/env bash

tag=${1}
darwin_sha_amd64=${2}
darwin_sha_arm64=${3}
linux_sha_amd64=${4}
linux_sha_arm64=${5}

if [ -z "${tag}" ]; then
  echo "release tag is not provided"
  exit 1
fi

if [ -z "${darwin_sha_amd64}" ]; then
  echo "darwin amd64 binary sha256sum is not provided"
  exit 1
fi

if [ -z "${darwin_sha_arm64}" ]; then
  echo "darwin arm64 binary sha256sum is not provided"
  exit 1
fi

if [ -z "${linux_sha_amd64}" ]; then
  echo "linux amd64 binary sha256sum is not provided"
  exit 1
fi

if [ -z "${linux_sha_arm64}" ]; then
  echo "linux arm64 binary sha256sum is not provided"
  exit 1
fi

echo $tag
echo $darwin_sha_amd64
echo $darwin_sha_arm64
echo $linux_sha_amd64
echo $linux_sha_arm64

# Remove the 'v' prefix from the tag if it exists
version=${tag#v}

# Get the current organization from the environment variable
org=${GITHUB_REPOSITORY_OWNER}

cat > gardenlogin.rb << EOF
# typed: true
# frozen_string_literal: true

# Gardenlogin is a formula for installing Gardenlogin
class Gardenlogin < Formula
  desc "Command-line tool for authenticating with Gardener clusters"
  homepage "https://gardener.cloud"
  version "$version"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/$org/gardenlogin/releases/download/$tag/gardenlogin_darwin_arm64"
      sha256 "$darwin_sha_arm64"
    else
      url "https://github.com/$org/gardenlogin/releases/download/$tag/gardenlogin_darwin_amd64"
      sha256 "$darwin_sha_amd64"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/$org/gardenlogin/releases/download/$tag/gardenlogin_linux_arm64"
      sha256 "$linux_sha_arm64"
    else
      url "https://github.com/$org/gardenlogin/releases/download/$tag/gardenlogin_linux_amd64"
      sha256 "$linux_sha_amd64"
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
EOF
