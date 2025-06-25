#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/helpers/formula-common.sh"

component=gardenctl-v2
tag=$1
darwin_sha_amd64=${2:-$empty_sha}
darwin_sha_arm64=${3:-$empty_sha}
linux_sha_amd64=${4:-$empty_sha}
linux_sha_arm64=${5:-$empty_sha}

desc="Command-line tool for managing Gardener clusters"
extra_dep='  depends_on "gardener/tap/gardenlogin"'
caveats=$(cat <<'EOS'
      Consider adding the gardenctl startup script to your shell profile.
      Run `gardenctl rc --help` for more information.
EOS
)

render_formula "$component" "$tag" "$desc" "$extra_dep" "" "$caveats" ""
