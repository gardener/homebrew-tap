#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/helpers/formula-common.sh"

component=gardenlogin
tag=$1
darwin_sha_amd64=${2:-$empty_sha}
darwin_sha_arm64=${3:-$empty_sha}
linux_sha_amd64=${4:-$empty_sha}
linux_sha_arm64=${5:-$empty_sha}

desc="Command-line tool for authenticating with Gardener clusters"
extra_install='    bin.install_symlink bin/"gardenlogin" => "kubectl-gardenlogin"'

caveats=$(cat <<'EOS'
      If you are using an OIDC kubeconfig, you may need to install 'kubelogin'.
      You can install it manually by running:
        brew install int128/kubelogin/kubelogin
EOS
)

extra_tests=$(cat <<'EOS'
    system "#{bin}/gardenlogin", "version"
    system "#{bin}/kubectl-gardenlogin", "version"
EOS
)

render_formula "$component" "$tag" "$desc" "" "$extra_install" "$caveats" "$extra_tests"
