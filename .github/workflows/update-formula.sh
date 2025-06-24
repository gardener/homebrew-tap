#!/usr/bin/env bash
set -euo pipefail

component=$1         # gardenlogin | gardenctl-v2 | diki
tag=$2
darwin_sha_amd64=$3
darwin_sha_arm64=$4
linux_sha_amd64=$5
linux_sha_arm64=$6

for v in "$component" "$tag" "$darwin_sha_amd64" "$darwin_sha_arm64" \
         "$linux_sha_amd64" "$linux_sha_arm64"; do
  [[ -z "$v" ]] && { echo "mandatory argument missing"; exit 1; }
done

version=${tag#v}                      # strip leading “v”
org=${GITHUB_REPOSITORY_OWNER}        # e.g. gardener

# ---------- choose template -------------------------------------------------
case "$component" in
  gardenlogin)   formula_file="gardenlogin.rb"   ;;
  gardenctl-v2)  formula_file="gardenctl-v2.rb"  ;;
  diki)          formula_file="diki.rb"          ;;
  *)
    echo "unknown component: $component"; exit 1 ;;
esac

# ---------- render template -------------------------------------------------
cat > "$formula_file" <<EOF
# typed: true
# frozen_string_literal: true

class $(tr '[:lower:]-' '[:upper:]_' <<<"$component" | sed 's/_V2/V2/') < Formula
  desc      "Auto-generated formula for $component"
  homepage  "https://gardener.cloud"
  version   "$version"

  $( [[ $component == gardenctl-v2 ]] && echo 'depends_on "gardener/tap/gardenlogin"' )

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/$org/$component/releases/download/$tag/${component//-/_}_darwin_arm64"
      sha256 "$darwin_sha_arm64"
    else
      url "https://github.com/$org/$component/releases/download/$tag/${component//-/_}_darwin_amd64"
      sha256 "$darwin_sha_amd64"
    fi
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/$org/$component/releases/download/$tag/${component//-/_}_linux_arm64"
      sha256 "$linux_sha_arm64"
    else
      url "https://github.com/$org/$component/releases/download/$tag/${component//-/_}_linux_amd64"
      sha256 "$linux_sha_amd64"
      depends_on arch: :x86_64
    fi
  end

  def install
    bin.install stable.url.split("/").last => "${component%%-*}"
  end

  test do
    system "\#{bin}/${component%%-*}", "version"
  end
end
EOF
