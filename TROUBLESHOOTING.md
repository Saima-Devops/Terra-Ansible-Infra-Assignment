# 🛠 `TROUBLESHOOTING GUIDE`

```md
## Troubleshooting Guide - TravelMemory Deployment
```

## ❌ 1. SSH Connection Timeout

### Error:

Connection timed out


### Fix:
- Check Security Group allows port 22
- Verify public IP of EC2
- Ensure correct key pair (`mern-key`)

---

## ❌ 2. MongoDB Connection Failed

### Error:
```bash
ECONNREFUSED 10.0.2.x:27017
```

### Fix:
- MongoDB must be running:

```bash
systemctl status mongod
Security group must allow:
27017 from Web SG
```

## ❌ 3. Ansible Host Not Reachable

Error:
UNREACHABLE via SSH

Fix:
Ensure ProxyJump is configured correctly
```
ansible_ssh_common_args='-o ProxyJump=bastion'
```

## ❌ 4. Git Not Found ON EC2

Error:
Failed to find executable git

Fix:
```
sudo dnf install git -y
```

## ❌ 5. PM2 App Not Starting

Error:
Errored status in PM2

Fix:
```
pm2 logs
pm2 delete all
pm2 restart all
```

## ❌ 6. Frontend Permission Error

Error:
EACCES: permission denied node_modules/.cache

Fix:
```
sudo chown -R ec2-user:ec2-user ~/TravelMemory
rm -rf node_modules/.cache
```


## ❌ 7. MongoDB Not Saving Data

Check:
Correct IP in .env

MongoDB running:
```
systemctl status mongod
```

## ❌ 8. Frontend Not Opening in Browser

Fix:
Use:
```
http://<EC2_PUBLIC_IP>:3000
```
NOT localhost

Check Security Group allows port 3000

## ❌ 9. Backend Not Responding

Fix:
```
curl http://localhost:3001/hello
pm2 restart travelmemory
```

## ✅ Verification Commands

```
pm2 list
systemctl status mongod
ss -tulpn | grep 3001
ss -tulpn | grep 3000

```

----

## 🎯 Final Checklist

- Terraform applied successfully
- Ansible configured EC2s
- MongoDB running in private subnet
- Backend running via PM2
- Frontend running via PM2
- Communication between all layers is working

-----
