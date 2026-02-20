# 🕒 Day 2: Temporary User Setup with Expiry

Temporary user accounts are useful for interns, contractors, training labs, and short-term access. In Linux, you can set an **account expiry date** so access is disabled automatically.

## What Is Account Expiry?

Account expiry defines the last date a user can log in. After that date, authentication is blocked even if the password is correct.

## Step 1: Create a Temporary User with Expiry

```bash
sudo useradd -m -e 2026-03-15 tempuser
sudo passwd tempuser
```

### Explanation

- `-m` → creates home directory (for normal temporary users)
- `-e 2026-03-15` → sets account expiry date (format: `YYYY-MM-DD`)
- `tempuser` → username

## Step 2: Set or Update Expiry for an Existing User

```bash
sudo chage -E 2026-03-15 tempuser
```

Use this when the user already exists and you want to enforce/adjust expiration. (chage = change age)

## Step 3: Verify Expiry Settings

```bash
sudo chage -l tempuser
```

Example output:

```text
Account expires                                        : Mar 15, 2026
Password expires                                       : never
Password inactive                                      : never
```

You can also verify directly from `/etc/shadow`:

```bash
sudo grep '^tempuser:' /etc/shadow
```

## Step 4: Test Behavior After Expiry

After the expiry date passes, login attempts via SSH/console/`su` should fail for that user.

To disable immediately (without waiting for date):

```bash
sudo chage -E 0 tempuser
```

## Remove Temporary User After Work Is Done

```bash
sudo userdel -r tempuser
```

- `-r` removes the user’s home directory and mail spool

## Extra Security Tips

- Give temporary users only required group access
- Use `sudo` rights only when absolutely necessary
- Set strong passwords or use SSH keys with limited scope
- Review old temporary accounts regularly

## Quick Command Reference

| Command | Purpose |
|---|---|
| `sudo useradd -m -e YYYY-MM-DD username` | Create user with expiry |
| `sudo chage -E YYYY-MM-DD username` | Set/change expiry date |
| `sudo chage -l username` | Check account aging details |
| `sudo chage -E 0 username` | Expire account immediately |
| `sudo userdel -r username` | Delete temporary account |
