# tzdata is the entire reason this image exists rather than using caddy:alpine
# directly. If it disappeared, TZ would silently fall back to UTC and logs
# would carry the wrong timestamps -- a quiet failure worth a loud test.
assert_file /usr/share/zoneinfo/America/New_York "tzdata is installed"
assert_eq "$(TZ=UTC date +%Z)" "UTC"             "UTC resolves"
ZONE=$(TZ=America/New_York date +%Z)
assert_ne "$ZONE" "UTC"                          "TZ actually changes the zone (got $ZONE)"
case "$ZONE" in EST|EDT) pass "TZ=America/New_York yields EST or EDT" ;; *) fail "TZ=America/New_York yields EST or EDT" "got $ZONE" ;; esac
