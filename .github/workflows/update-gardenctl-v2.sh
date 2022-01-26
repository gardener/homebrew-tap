#!/usr/bin/env bash

tag=${1}
darwin_sha_amd64=${2}
darwin_sha_arm64=${3}
linux_sha_amd64=${4}
if [ -z "${1}" ]
then
      echo "release tag is not provided"
      exit 1
fi
if [ -z "${2}" ]
then
      echo "darwin amd64 binary sha256sum is not provided"
      exit 1
fi
if [ -z "${3}" ]
then
      echo "darwin arm64 binary sha256sum is not provided"
      exit 1
fi
if [ -z "${4}" ]
then
      echo "linux binary sha256sum is not provided"
      exit 1
fi

echo $tag
echo $darwin_sha_amd64
echo $darwin_sha_arm64
echo $linux_sha_amd64

cat > gardenctl-v2.rb << EOF
class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "$tag"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/$tag/gardenctl_v2_darwin_arm64"
      sha256 "$darwin_sha_arm64"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/$tag/gardenctl_v2_darwin_amd64"
      sha256 "$darwin_sha_amd64"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl-v2/releases/download/$tag/gardenctl_v2_linux_amd64"
    sha256 "$linux_sha_amd64"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end

EOF
