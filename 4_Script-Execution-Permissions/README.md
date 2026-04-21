# Day 4: Script Execution Permissions

## 🎯 task
Grant executable permission to `/tmp/xfusioncorp.sh` on `App Server 1` so all users can run it.

## Why `Permission denied` happened
If the file mode is `---x--x--x`, users have only execute permission, but no read permission.

For shell scripts, read permission is also required by the interpreter (`/bin/bash`) to read script contents. So this command fails:

```bash
./xfusioncorp.sh
```

with:

```bash
/bin/bash: ./xfusioncorp.sh: Permission denied
```

## Correct Solution

Use:

```bash
sudo chmod 755 /tmp/xfusioncorp.sh
```

This sets:
- owner: `rwx`
- group: `r-x`
- others: `r-x`

So everyone can execute it, and required read bits are present.

## Verify

Before (problematic example):

```bash
ls -lh /tmp/xfusioncorp.sh
---x--x--x 1 root root 40 Feb 22 13:48 /tmp/xfusioncorp.sh
```

After (correct):

```bash
ls -lh /tmp/xfusioncorp.sh
-rwxr-xr-x 1 root root 40 Feb 22 13:48 /tmp/xfusioncorp.sh
```


