# Bitwarden on Google Cloud Docker Image - Caddy

This is the proxy container repository for the [Bitwarden self-hosted on Google Cloud for Free](https://github.com/dadatuputi/bitwarden_gcloud) project.

## Changes

Base Image: `caddy:alpine`

Changes to Base Image: Add tzdata package so timezone is set using `TZ` env variable
