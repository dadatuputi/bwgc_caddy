# The binary and its version should be present and runnable.
command -v caddy >/dev/null 2>&1 && pass "caddy is on PATH" || fail "caddy is on PATH"
VER=$(caddy version 2>/dev/null | head -1)
assert_ne "$VER" "" "caddy reports a version ($VER)"

# A Caddyfile of the shape this project mounts must validate. This is the
# header block the parent repo ships, including the empty matcher that replaced
# "header /" so the headers apply to every path rather than the root only.
cat > /tmp/Caddyfile <<'CADDY'
{
  admin off
}
example.test {
  header {
       Strict-Transport-Security "max-age=31536000;"
       X-Frame-Options "DENY"
       X-Content-Type-Options "nosniff"
       X-Robots-Tag "noindex, nofollow"
       -Server
  }
  reverse_proxy localhost:80 {
       header_up X-Real-IP {remote_host}
  }
}
CADDY
OUT=$(caddy validate --config /tmp/Caddyfile --adapter caddyfile 2>&1); STATUS=$?
assert_status "$STATUS" 0 "a project-shaped Caddyfile validates"
assert_not_contains "$OUT" "unrecognized" "no unrecognized directives"
