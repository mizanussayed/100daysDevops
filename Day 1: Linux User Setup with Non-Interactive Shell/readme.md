# 🐧 Day 1: Linux User Setup with Non-Interactive Shell

When managing Linux servers, you often need users that **cannot log in interactively**. These are usually service accounts for apps, automation, and background processes.

## What Is a Non-Interactive Shell?

A non-interactive shell blocks user login through:

- SSH
- Console/Tty login
- `su - <username>`

Instead of normal shells like `/bin/bash`, assign one of these:

- `/usr/sbin/nologin` (or `/sbin/nologin` on some distros)
- `/bin/false`

## Step 1: Create a Service User with No Login Access

```bash
sudo useradd -r -s /usr/sbin/nologin appuser
```

### Explanation

- `-r` → creates a system account (typically UID < 1000)
- `-s /usr/sbin/nologin` → disables interactive login
- `appuser` → username

Here’s what they stand for:
- `-r` → r = system (reserved) account
Creates a system user (used for services, not regular login users).

- `-s` → s = shell
Sets the user’s login shell

## Step 2: Verify the User

```bash
grep appuser /etc/passwd
```

Example output:

```text
appuser:x:998:998::/home/appuser:/usr/sbin/nologin
```

The last field confirms the assigned shell.

## Step 3: Test Login Behavior

```bash
su - appuser
```

Expected result:

```text
This account is currently not available.
```

## Alternative: Use `/bin/false`

```bash
sudo useradd -r -s /bin/false serviceuser
```

Difference:

- `/usr/sbin/nologin` → shows a message, then exits
- `/bin/false` → exits immediately (no message)

## Disable Login for an Existing User

```bash
sudo usermod -s /usr/sbin/nologin username
```

## Extra Security Tips

If password login is not required, lock the account password:

```bash
sudo passwd -l appuser
```

## Quick Comparison

| Shell | Allows Login? | Shows Message? |
|---|---|---|
| `/bin/bash` | ✅ Yes | — |
| `/usr/sbin/nologin` | ❌ No | ✅ Yes |
| `/bin/false` | ❌ No | ❌ No |

## Common Use Cases

- Web server processes
- Database services
- CI/CD runners
- Application daemons
- Automation scripts