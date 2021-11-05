#!/usr/bin/env bash

tag=${1}
mac_sha=${2}
linux_sha=${3}
if [ -z "${1}" ]
then
      echo "release tag is not provided"
      exit 1
fi
if [ -z "${2}" ]
then
      echo "mac binary sha256sum is not provided"
      exit 1
fi
if [ -z "${3}" ]
then
      echo "linux binary sha256sum is not provided"
      exit 1
fi

echo $tag
echo $mac_sha
echo $linux_sha

cat > gardenctl-v2.rb << EOF
class Gardenctl < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "$tag"

  if OS.mac?
    url "https://github.com/gardener/gardenctl-v2/releases/download/$tag/gardenctl_v2_darwin_amd64"
    sha256 "$mac_sha"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl-v2/releases/download/$tag/gardenctl_v2_linux_amd64"
    sha256 "$linux_sha"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl-v2"
  end

  test do
    system "#{bin}/gardenctl-v2", "version"
  end
end

EOF