# Caddy's major version is pinned. Deployments follow this image's own major
# tag (:1), which promises nothing a deployment must change, but the nightly
# rebuild pulls whatever the base tag points at. With caddy:alpine, a Caddy 3
# release would have reached every deployment overnight, tested only against
# the sample Caddyfile in tests/. 2-alpine still brings every 2.x release and
# Alpine security fix; moving to a new major is a reviewed change here, released
# as release:major.
FROM caddy:2-alpine

# apk upgrade first: the base image's own packages (apk-tools, for one) can lag
# the repository index, and the nightly rebuild only helps if it brings them up
# to date too.
RUN apk upgrade --no-cache && apk add --no-cache tzdata
