#!/usr/bin/env bash
#
# Build tank.smx from source.
#
# Fetches the pinned SourceMod compiler and the pinned TF2Items include into
# .build/, then compiles addons/sourcemod/scripting/tank.sp.
#
# Usage:
#   scripts/build.sh             build to build/tank.smx
#   scripts/build.sh --install   also copy it to addons/sourcemod/plugins/
#
set -euo pipefail

SM_BRANCH="1.12"
SM_VERSION="1.12.0-git7255"
TF2ITEMS_COMMIT="e3508121c09f0d2a3d7721ce109d7727f32bd078"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$ROOT/.build"
OUT_DIR="$ROOT/build"
SM_DIR="$BUILD_DIR/sourcemod-$SM_VERSION"
TF2ITEMS_DIR="$BUILD_DIR/tf2items"

mkdir -p "$BUILD_DIR" "$OUT_DIR"

if [ ! -x "$SM_DIR/addons/sourcemod/scripting/spcomp64" ]; then
	echo "Fetching SourceMod $SM_VERSION"
	curl -fsSL "https://sm.alliedmods.net/smdrop/$SM_BRANCH/sourcemod-$SM_VERSION-linux.tar.gz" \
		-o "$BUILD_DIR/sm.tar.gz"
	mkdir -p "$SM_DIR"
	tar xzf "$BUILD_DIR/sm.tar.gz" -C "$SM_DIR"
	rm -f "$BUILD_DIR/sm.tar.gz"
fi

if [ ! -f "$TF2ITEMS_DIR/tf2items.inc" ]; then
	echo "Fetching tf2items.inc at $TF2ITEMS_COMMIT"
	mkdir -p "$TF2ITEMS_DIR"
	curl -fsSL "https://raw.githubusercontent.com/asherkin/TF2Items/$TF2ITEMS_COMMIT/pawn/tf2items.inc" \
		-o "$TF2ITEMS_DIR/tf2items.inc"
fi

"$SM_DIR/addons/sourcemod/scripting/spcomp64" \
	"$ROOT/addons/sourcemod/scripting/tank.sp" \
	-i "$ROOT/addons/sourcemod/scripting/include" \
	-i "$TF2ITEMS_DIR" \
	-i "$SM_DIR/addons/sourcemod/scripting/include" \
	-o "$OUT_DIR/tank.smx"

echo "Built $OUT_DIR/tank.smx"

if [ "${1:-}" = "--install" ]; then
	cp "$OUT_DIR/tank.smx" "$ROOT/addons/sourcemod/plugins/tank.smx"
	echo "Installed addons/sourcemod/plugins/tank.smx"
fi
