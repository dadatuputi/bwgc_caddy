FROM caddy:alpine

# apk upgrade first: the base image's own packages (apk-tools, for one) can lag
# the repository index, and the nightly rebuild only helps if it brings them up
# to date too.
RUN apk upgrade --no-cache && apk add --no-cache tzdata
