#!/bin/sh
# admin / hackademic (set by the install wizard) logs in and lands on the admin dashboard.
set -e
jar=$(mktemp)
loc=$(curl -sS -c "$jar" -b "$jar" -o /dev/null -w '%{redirect_url}' \
  --data "username=admin&pwd=hackademic&submit=Login" http://hackademic/pages/login.php)
echo "redirect: $loc"
echo "$loc" | grep -q "admin/pages/dashboard.php"
