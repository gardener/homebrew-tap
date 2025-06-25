#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/helpers/formula-common.sh"

component=gardenlogin
tag=$1
DARWIN_SHA_AMD64=${2:-$empty_sha}
DARWIN_SHA_ARM64=${3:-$empty_sha}
LINUX_SHA_AMD64=${4:-$empty_sha}
LINUX_SHA_ARM64=${5:-$empty_sha}

desc="Command-line tool for authenticating with Gardener clusters"
extra_install='    bin.install_symlink bin/"gardenlogin" => "kubectl-gardenlogin"'
caveats=$(cat <<'EOS'
      If you are using an OIDC kubeconfig, you may need to install 'kubelogin'.
      You can install it manually by running:
        brew install int128/kubelogin/kubelogin
EOS
)

render_formula "$component" "$tag" "$desc" "" "$extra_install" "$caveats"
