#!/usr/bin/env sh
#
# Test suite for bwgc_caddy.
#
# This image is three lines: caddy plus tzdata. The surface is correspondingly
# small, so these tests assert the few things that could actually regress --
# that the timezone package the image exists to add is present and working,
# that caddy still runs, and that a Caddyfile of the shape this project mounts
# is accepted. There is deliberately no attempt to test Caddy itself.
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
FILTER="${1:-}"

if [ -n "${BWGC_IMAGE:-}" ]; then
	IMAGE="$BWGC_IMAGE"
	printf 'testing existing image: %s\n' "$IMAGE"
else
	IMAGE=bwgc_caddy:test
	printf 'building %s\n' "$IMAGE"
	docker build -q -t "$IMAGE" "$ROOT" >/dev/null
fi

docker run --rm -e FILTER="$FILTER" -e TZ=America/New_York \
	-v "$ROOT/tests:/tests:ro" \
	--entrypoint sh "$IMAGE" /tests/in-container.sh
