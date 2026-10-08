#!/bin/sh
# Runs Hackademic's install wizard (/installation/install.php: admin account, database, config)
# once Apache and the database answer, so the lab starts ready: admin / hackademic. When the
# database already holds Hackademic (the web container was recreated), only config.inc.php is
# written again, the way the wizard writes it, so the player's progress stays.
cfg=/var/www/html/config.inc.php
db_ready() {
  php -r 'exit(@new mysqli("db","root","hackademic") && !mysqli_connect_errno() ? 0 : 1);' 2>/dev/null
}
installed() {
  php -r '$c=@new mysqli("db","root","hackademic","hackademic"); exit(!$c->connect_errno && $c->query("SELECT 1 FROM users LIMIT 1") ? 0 : 1);' 2>/dev/null
}
write_config() {
  sed -e 's|#YOUR_APP_TITLE_HERE#|Hackademic CMS|' -e 's|#YOUR_SITE_ROOT_PATH#|/|' \
      -e 's|#YOUR_SOURCE_ROOT_PATH#|/|' -e 's|#YOUR_DBHOST#|db|' -e 's|#YOUR_DBUSER#|root|' \
      -e 's|#YOUR_DBPASS#|hackademic|' -e 's|#YOUR_DBNAME#|hackademic|' \
      /var/www/html/sample.config.inc.php > "$cfg" && chown www-data:www-data "$cfg"
}
jar=/tmp/hackademic-install.cookies
wizard() {
  u=http://127.0.0.1/installation/install.php
  rm -f "$jar"
  curl -fsS -c "$jar" -b "$jar" -o /dev/null --data 'step=db&email=admin@hackademic.local&username=admin&password=hackademic' $u &&
  curl -fsS -c "$jar" -b "$jar" -o /dev/null --max-time 120 \
    --data 'step=dbdone&dbname=hackademic&dbuser=root&dbpass=hackademic&dbhost=db&create_database=yes&empty_database=no' $u &&
  curl -fsS -c "$jar" -b "$jar" -o /dev/null \
    --data 'step=finish&app_title=Hackademic CMS&source_root_path=/&site_root_path=/' $u
}
for i in $(seq 1 90); do
  if [ -f "$cfg" ] && installed; then echo "hackademic-install: installed"; rm -f "$jar"; exit 0; fi
  if db_ready; then
    if installed; then write_config; else wizard 2>/dev/null; fi
  fi
  sleep 2
done
echo "hackademic-install: install failed"; exit 1
