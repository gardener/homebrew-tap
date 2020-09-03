#!/usr/bin/env bash

tag=${1:-v0.17.0}
mac_sha=${2:-f6cbd049d200a1857e9bb89cd614f0f96851ef2db307a18609a18effbb4497eb}
linux_sha=${3:-f6cbd049d200a1857e9bb89cd614f0f96851ef2db307a18609a18effbb4497eb}

echo $tag
echo $mac_sha
echo $linux_sha

cat > gardenctl.rb << EOF
class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "$tag"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/$tag/gardenctl-darwin-amd64"
    sha256 "$mac_sha"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/$tag/gardenctl-linux-amd64"
    sha256 "$linux_sha"
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
