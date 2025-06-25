#!/usr/bin/env bash
set -euo pipefail

empty_sha=e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855

pascal_case() {                       # gardenctl-v2 → GardenctlV2
  IFS='-' read -ra parts <<<"$1"; local out=""; for p in "${parts[@]}"; do
    out+=${p^}; done; echo "$out"
}

render_formula() {
  local component=$1 tag=$2 desc=$3 extra_dep=$4 extra_install=$5 caveats=$6
  local version=${tag#v} org=${GITHUB_REPOSITORY_OWNER}
  local class_name
  class_name=$(pascal_case "$component")

  # shell-safe heredoc delimiter
  cat > "${component}.rb" <<EOF
# typed: true
# frozen_string_literal: true

class ${class_name} < Formula
  desc      "${desc}"
  homepage  "https://gardener.cloud"
  version   "${version}"
${extra_dep}

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/${org}/${component}/releases/download/${tag}/${component//-/_}_darwin_arm64"
      sha256 "\${DARWIN_SHA_ARM64}"
    else
      url "https://github.com/${org}/${component}/releases/download/${tag}/${component//-/_}_darwin_amd64"
      sha256 "\${DARWIN_SHA_AMD64}"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/${org}/${component}/releases/download/${tag}/${component//-/_}_linux_arm64"
      sha256 "\${LINUX_SHA_ARM64}"
    else
      url "https://github.com/${org}/${component}/releases/download/${tag}/${component//-/_}_linux_amd64"
      sha256 "\${LINUX_SHA_AMD64}"
      depends_on arch: :x86_64
    end
  end

  def install
    bin.install stable.url.split("/").last => "${component%%-*}"
${extra_install}
  end
EOF

  # optional caveats
  if [[ -n "${caveats}" ]]; then
    cat >> "${component}.rb" <<EOF

  def caveats
    <<~EOS
${caveats}
    EOS
  end
EOF
  fi

  cat >> "${component}.rb" <<'EOF'

  test do
    system "#{bin}/'${component%%-*}'", "version"
  end
end
EOF
}
