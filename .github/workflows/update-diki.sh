#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/helpers/formula-common.sh"

component=diki
tag=$1
DARWIN_SHA_AMD64=${2:-$empty_sha}
DARWIN_SHA_ARM64=${3:-$empty_sha}
LINUX_SHA_AMD64=${4:-$empty_sha}
LINUX_SHA_ARM64=${5:-$empty_sha}

desc="Command-line tool for compliance checks"

render_formula "$component" "$tag" "$desc" "" "" "" ""
