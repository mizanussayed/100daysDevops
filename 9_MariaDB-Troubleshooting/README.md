# Day 9: MariaDB Troubleshooting

## 🎯 task
The Nautilus application was unable to connect to the database in Stratos DC.
Initial investigation showed the MariaDB service was down on the DB server (`stdb01`).

## Issue Observed
- `mariadb.service` was not running.
- App-side database connectivity was failing.

## Solution (Executed)

1. Check MariaDB service status:

```bash
systemctl status mariadb.service
```

2. Restart MariaDB service:

```bash
sudo systemctl restart mariadb
```

3. Verify service is healthy:

```bash
systemctl status mariadb.service
```

Expected confirmation:
- `Active: active (running)`
- `Status: "Taking your SQL requests now..."`

4. Validate DB access from server:

```bash
sudo mysql -e "SHOW DATABASES;"
```

Output confirmed database connectivity:
- `information_schema`
- `mysql`
- `performance_schema`

## Notes
- If `restart` fails, inspect logs:

```bash
sudo journalctl -xeu mariadb.service
```

- For this environment, root DB access works via `sudo mysql` (socket authentication), so no separate MariaDB root password was required.

## Final Status
MariaDB service was restored and verified. The database layer is healthy again for application connectivity.
systemctl status mariadb



