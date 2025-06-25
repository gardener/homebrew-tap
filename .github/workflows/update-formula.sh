#!/usr/bin/env bash
set -euo pipefail

#######################################################################
# 1. positional parameters --------------------------------------------
#######################################################################
component=$1   # gardenlogin | gardenctl-v2 | diki
tag=$2
darwin_sha_amd64=${3:-}
darwin_sha_arm64=${4:-}
linux_sha_amd64=${5:-}
linux_sha_arm64=${6:-}

empty_sha=e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
darwin_sha_amd64=${darwin_sha_amd64:-$empty_sha}
darwin_sha_arm64=${darwin_sha_arm64:-$empty_sha}
linux_sha_amd64=${linux_sha_amd64:-$empty_sha}
linux_sha_arm64=${linux_sha_arm64:-$empty_sha}

[ -z "$component" ] || [ -z "$tag" ] && { echo "component and tag required"; exit 1; }

version=${tag#v}
org=${GITHUB_REPOSITORY_OWNER}

#######################################################################
# 2. helpers -----------------------------------------------------------
#######################################################################
pascal_case() {                                   # gardenctl-v2 → GardenctlV2
  IFS='-' read -ra parts <<<"$1"
  local out=""
  for p in "${parts[@]}"; do
    out+=${p^}
  done
  echo "$out"
}

# component-specific metadata
declare -A desc extra_dep extra_caveats extra_install
desc[gardenlogin]="Command-line tool for authenticating with Gardener clusters"
desc[gardenctl-v2]="Command-line tool for managing Gardener clusters"
desc[diki]="Command-line tool for compliance checks"

extra_dep[gardenctl-v2]='  depends_on "gardener/tap/gardenlogin"'

extra_install[gardenlogin]='    bin.install_symlink bin/"gardenlogin" => "kubectl-gardenlogin"'

read -r -d '' caveat_gl <<'CAV'
      If you are using an OIDC kubeconfig, you may need to install 'kubelogin'.
      You can install it manually by running:
        brew install int128/kubelogin/kubelogin
CAV

read -r -d '' caveat_gc <<'CAV'
      Consider adding the gardenctl startup script to your shell profile.
      It contains various tweaks, such as setting environment variables,
      loading completions, and adding some helpful aliases or functions.
      Run `gardenctl rc --help` for more information.
CAV

extra_caveats[gardenlogin]="$caveat_gl"
extra_caveats[gardenctl-v2]="$caveat_gc"

#######################################################################
# 3. render formula ----------------------------------------------------
#######################################################################
class_name=$(pascal_case "$component")
formula_file="${component}.rb"

cat > "$formula_file" <<EOF
# typed: true
# frozen_string_literal: true

# ${class_name} is a formula for installing ${class_name}
class ${class_name} < Formula
  desc  "${desc[$component]}"
  homepage "https://gardener.cloud"
  version "$version"
${extra_dep[$component]:-}

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/$org/$component/releases/download/$tag/${component//-/_}_darwin_arm64"
      sha256 "$darwin_sha_arm64"
    else
      url "https://github.com/$org/$component/releases/download/$tag/${component//-/_}_darwin_amd64"
      sha256 "$darwin_sha_amd64"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/$org/$component/releases/download/$tag/${component//-/_}_linux_arm64"
      sha256 "$linux_sha_arm64"
    else
      url "https://github.com/$org/$component/releases/download/$tag/${component//-/_}_linux_amd64"
      sha256 "$linux_sha_amd64"
      depends_on arch: :x86_64
    end
  end

  def install
    bin.install stable.url.split("/").last => "${component%%-*}"
${extra_install[$component]:-}
  end
EOF

# optional caveats section
if [[ -n ${extra_caveats[$component]:-} ]]; then
cat >> "$formula_file" <<EOF

  def caveats
    <<~EOS
${extra_caveats[$component]}
    EOS
  end
EOF
fi

# closing test & class end
cat >> "$formula_file" <<'EOF'

  test do
    system "#{bin}/'${component%%-*}'", "version"
  end
end
EOF
