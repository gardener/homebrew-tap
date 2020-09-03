#!/usr/bin/env bash

filteredTag=${1##*/}
tag=${filteredTag:-v0.17.0}
sha=${2:-8d33c751e8d32fe7fff15306c7de59cf15c45fb04e2f9abf988d3edd3f305cc4}

echo $tag

cat > gardenctl.rb << EOF
class Gardenctl < Formula
  desc "Gardenctl"
  homepage "https://gardener.cloud"
  version "$tag"

  if OS.mac?
    url "https://github.com/gardener/gardenctl/releases/download/$tag/gardenctl-darwin-amd64"
    sha256 "$sha"
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl/releases/download/$tag/gardenctl-linux-amd64"
    sha256 "$sha"
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
