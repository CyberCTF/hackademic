# The MySQL Hackademic expects, as MariaDB 10.11 with the values baked in: Hackademic connects as
# root (the izon challenge creates and drops temporary databases and users, so its account needs
# full privileges) with the password hackademic, creates its hackademic database itself (install
# wizard), and the server runs with MySQL 5.5's permissive SQL mode (zero dates in its seed).
FROM docker.io/library/mariadb:10.11
ENV MARIADB_ROOT_PASSWORD=hackademic
CMD ["mariadbd", "--sql-mode=NO_ENGINE_SUBSTITUTION"]
