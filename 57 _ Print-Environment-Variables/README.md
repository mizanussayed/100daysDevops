# Day 57: Print Environment Variables

## 🎯 Task
1. Create a pod named print-envars-greeting.

2. Configure spec as, the container name should be print-env-container and use bash image.

3. Create three environment variables:

    a. GREETING and its value should be Welcome to

    b. COMPANY and its value should be DevOps

    c. GROUP and its value should be Group

4. Use command ["/bin/sh", "-c", 'echo "$(GREETING) $(COMPANY) $(GROUP)"'] (please use this exact command), also set its restartPolicy policy to Never to avoid crash loop back.

5. You can check the output using kubectl logs -f print-envars-greeting command.

## 📝 Solution

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: print-envars-greeting
spec:
  containers:
    - name: print-env-container
      image: bash
      env:
        - name: GREETING
          value: "Welcome to"
        - name: COMPANY
          value: "DevOps"
        - name: GROUP
          value: "Group"
      command: ["/bin/sh", "-c", 'echo "$(GREETING) $(COMPANY) $(GROUP)"']
```

## 🧪 Test
3. Check the logs to see the output:
```bash
   kubectl logs -f print-envars-greeting
```

