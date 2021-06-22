#!/usr/bin/env bash

tag=${1}
darwin_sha=${2}
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
echo $darwin_sha
echo $linux_sha

cat > gardenlogin.rb << EOF
class Gardenlogin < Formula
  desc "Gardenlogin"
  homepage "https://gardener.cloud"
  version "$tag"

  if OS.mac?
    url "https://github.com/gardener/gardenlogin/releases/download/$tag/gardenlogin-darwin-amd64"
    sha256 "$darwin_sha"
  elsif OS.linux?
    url "https://github.com/gardener/gardenlogin/releases/download/$tag/gardenlogin-linux-amd64"
    sha256 "$linux_sha"
  end

  depends_on :arch => :x86_64

  def install
    bin.install stable.url.split("/")[-1] => "gardenlogin"
  end

  test do
    system "#{bin}/gardenlogin", "version"
  end
end

EOF
