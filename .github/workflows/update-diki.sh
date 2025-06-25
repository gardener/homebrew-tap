#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/helpers/formula-common.sh"

component=diki
tag=$1
darwin_sha_amd64=${2:-$empty_sha}
darwin_sha_arm64=${3:-$empty_sha}
linux_sha_amd64=${4:-$empty_sha}
linux_sha_arm64=${5:-$empty_sha}

desc="Command-line tool for compliance checks"

render_formula "$component" "$tag" "$desc" "" "" "" ""
