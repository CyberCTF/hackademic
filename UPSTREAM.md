# Upstream

| | |
| --- | --- |
| Project | OWASP Hackademic Challenges |
| Repository | https://github.com/Hackademic/hackademic (archived) |
| Version | next (default branch, upstream's stable branch; no releases) |
| Commit | 873d8b31222ff6cee8b0cbe149295e226d25396d |
| Licence | GPL-3.0 |

`build/hackademic/app/` is that commit, unchanged, without its Git history. Upstream has no
Dockerfile: `build/hackademic/Dockerfile` serves it on `php:5.6-apache` (its Smarty 3.1.8
predates PHP 7) with `pdo_mysql` and `mysqli`, and runs `install.sh` in the background at start,
which goes through upstream's install wizard once (admin / hackademic, database `hackademic` on
the db machine as root, site and source root `/`). `build/db/Dockerfile` is MariaDB 10.11 with
the root password baked in and MySQL 5.5's permissive SQL mode. To update, replace
`build/hackademic/app/` with a newer commit, then change this table.
