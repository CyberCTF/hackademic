# OWASP Hackademic Challenges

[Hackademic](https://github.com/Hackademic/hackademic) (OWASP Hackademic Challenges) by the
Hackademic contributors: a training platform where students attack realistic, vulnerable
scenarios in a safe environment, organised in classes with an admin dashboard and scoring. This
repository runs it with [Isoloom](https://www.isoloom.com): [`isoloom.yml`](isoloom.yml)
describes the machines, and the upstream source in [`build/hackademic/app/`](build/hackademic/app)
is served by a PHP 5.6 / Apache image written for it (upstream ships no Dockerfile), with the
install wizard run at first start.

| Machine | Service |
| --- | --- |
| hackademic | Hackademic (PHP 5.6, Apache) on port 80, published on 8028 |
| db | MariaDB 10.11 on port 3306 |

## Run it

```bash
isoloom generate
isoloom up docker
```

Then open http://localhost:8028/ and log in as `admin` / `hackademic`. Students register from the
login page; the admin adds them to a class. The same spec runs as Docker on a local VM
(`docker-vm`), on a cloud VM (`cloud-docker`) or on Kubernetes. Lab guide: the
[project README](https://github.com/Hackademic/hackademic#readme) and the description of each
challenge.

Upstream version and commit: [UPSTREAM.md](UPSTREAM.md).

## Licence

GPL-3.0, as Hackademic ([LICENSE](LICENSE), upstream's `LICENSE.txt`). This application is
deliberately vulnerable: keep it isolated.
