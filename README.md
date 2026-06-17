# TravelMemory MERN Stack Deployment on AWS (Terraform + Ansible)


## Introduction

This project demonstrates the deployment of the TravelMemory MERN (MongoDB, Express.js, React.js, and Node.js) application on AWS using DevOps automation tools. The infrastructure was provisioned using Terraform, while Ansible was used to configure servers, install dependencies, and deploy the application. The solution follows a secure architecture where the web server resides in a public subnet and the MongoDB server is hosted in a private subnet.

### Why Terraform?

Terraform is an Infrastructure as Code (IaC) tool used to provision and manage cloud resources in a declarative manner. Instead of manually creating AWS resources through the console, Terraform allows the entire infrastructure to be defined as code and deployed consistently across environments.

### Benefits of Terraform
 
- Automates infrastructure provisioning and management.
- Ensures consistency and repeatability across deployments.
- Supports version control and collaboration through code.
- Reduces manual configuration errors.
- Enables quick infrastructure recreation and disaster recovery.
- Provides a clear execution plan before applying changes.
- Why Ansible?

### Why Ansible?

Ansible is a configuration management and automation tool used to configure servers, install software, and deploy applications. After Terraform provisions the infrastructure, Ansible automates the setup of the operating system, application dependencies, MongoDB configuration, and application deployment.

### Benefits of Ansible

- Agentless architecture using SSH for communication.
- Simplifies server configuration and application deployment.
- Ensures consistent configuration across multiple servers.
- Uses human-readable YAML playbooks.
- Supports idempotent operations, preventing unnecessary changes.
- Reduces deployment time and operational overhead.

----

## 📌 Project Overview

This project demonstrates the deployment of a **MERN Stack Application (TravelMemory)** on AWS using:

- Terraform (Infrastructure as Code)
- Ansible (Configuration Management)
- AWS EC2 (Web + MongoDB instances)
- PM2 (Process Manager)
- MongoDB (Private Subnet)
- React + Node.js (Frontend + Backend)

---

## 🏗 Architecture

```mermaid
graph TD

User["User / Browser"]

subgraph AWS_VPC["AWS VPC"]

    IGW["Internet Gateway"]

    subgraph PublicSubnet["Public Subnet"]
        WebEC2["Web EC2
React
Node.js
PM2"]
    end

    subgraph PrivateSubnet["Private Subnet"]
        MongoEC2["MongoDB EC2"]
    end

    NAT["NAT Gateway"]

end

User --> IGW
IGW --> WebEC2
WebEC2 -->|Port 27017| MongoEC2
MongoEC2 --> NAT
```
---

## ⚙️ Tech Stack

- AWS EC2
- Terraform
- Ansible
- Node.js (Express)
- React.js
- MongoDB
- PM2
- Git

-----

## 📁 Project Structure

```bash

TravelMemory/
│
├── backend/
│   ├── index.js
│   ├── conn.js
│   ├── routes/
│   └── models/
│
├── frontend/
│   ├── src/
│   └── public/
│
├── terraform/
│   ├── vpc.tf
│   ├── ec2.tf
│   ├── security.tf
│   ├── outputs.tf
│
├── ansible/
│   ├── inventory.ini
│   ├── web.yml
│   ├── mongodb.yml
│   ├── deploy.yml

```

----

## Infrastructure Setup (Terraform)

### Components Created

- VPC with public & private subnet
- Internet Gateway
- NAT Gateway
- Route Tables
- EC2 Web Server (Public Subnet)
- EC2 MongoDB Server (Private Subnet)
- Security Groups
- IAM Roles
- Key Pair (`mern-key`)

---

## 🔐 Security Groups

### Web Server SG

- SSH: 22 (My IP)
- HTTP: 80 (0.0.0.0/0)
- HTTPS: 443
- React: 3000
- Node API: 3001

### MongoDB SG

- SSH: 22 (from Web SG only)
- MongoDB: 27017 (from Web SG only)

----
## 📦 Ansible Configuration

### Inventory

```ini
[web]
<WEB_PUBLIC_IP>

[bastion]
<WEB_PUBLIC_IP>

[mongodb]
<PRIVATE_IP>

[all:vars]
ansible_user=ec2-user
ansible_ssh_private_key_file=~/.ssh/mern-key

[mongodb:vars]
ansible_ssh_common_args='-o ProxyJump=bastion'
```

---

## 🏗 Web Server Setup (web.yml)

Installs:

- Git
- Node.js
- npm
- PM2

-----

## 🚀 Application Deployment (deploy.yml)

Steps:
- Clone GitHub repository
- Install backend dependencies
- Configure .env for backend
- Install frontend dependencies
- Configure .env for frontend
- Start backend using PM2
- Start frontend using PM2

-----

## Environment Variables

**Backend (.env)**

```bash
PORT=3001
MONGO_URI=mongodb://<MONGO_PRIVATE_IP>:27017/travelmemory
```

**Frontend (.env)**

```bash
REACT_APP_BACKEND_URL=http://<WEB_PUBLIC_IP>:3001
```

------

## Application URLs


**Frontend**

```bash
http://<WEB_PUBLIC_IP>:3000
```

**Backend API**

```bash
http://<WEB_PUBLIC_IP>:3001/hello
http://<WEB_PUBLIC_IP>:3001/trip
```
---

## 📊 Process Management (PM2)

```bash
pm2 list
pm2 logs
pm2 restart all
pm2 save
```

---

## 🗄 MongoDB Setup

Database runs on private EC2:

```bash
mongodb://10.0.2.x:27017
```

---

## Key Features Implemented

- VPC with public/private subnet architecture
- Bastion-like access via web server
- Private MongoDB deployment
- Automated provisioning using Terraform
- Configuration using Ansible
- CI-style deployment workflow
- Process management with PM2

----

## Common Commands Used in the Project

### AWS CLI

```bash
aws configure
aws sts get-caller-identity
```

### Terraform

```bash
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply
terraform output
terraform state list
terraform destroy
```

<img width="2560" height="1600" alt="image" src="https://github.com/user-attachments/assets/39984bb6-1c4a-4d31-ab09-9bc88473e233" />

<img width="1280" height="800" alt="Screenshot 2026-06-16 at 1 29 03 PM" src="https://github.com/user-attachments/assets/a2eb273e-4e27-407d-a65c-4fb3162b0a37" />

<img width="1280" height="800" alt="Screenshot 2026-06-16 at 1 29 32 PM" src="https://github.com/user-attachments/assets/de32f546-5505-446e-9d7e-e346442d4d3d" />

<img width="1280" height="800" alt="Screenshot 2026-06-16 at 1 32 00 PM" src="https://github.com/user-attachments/assets/6eb2bd0d-c041-40e4-b2b4-6d93e90498b0" />

<img width="1280" height="800" alt="Screenshot 2026-06-16 at 1 31 44 PM" src="https://github.com/user-attachments/assets/511c0130-086d-4c75-9f55-592019511060" />

<img width="1280" height="800" alt="Screenshot 2026-06-16 at 1 32 09 PM" src="https://github.com/user-attachments/assets/3d3f0a6e-80e8-4223-a0bc-2aa5b054431b" />


<img width="1280" height="800" alt="Screenshot 2026-06-16 at 1 32 36 PM" src="https://github.com/user-attachments/assets/a0bacb34-451e-4974-990e-236fbdd929b3" />

<img width="1280" height="800" alt="Screenshot 2026-06-16 at 1 32 20 PM" src="https://github.com/user-attachments/assets/04ed9128-eed2-42f4-ab9c-222329a62e74" />

-----

### SSH Connectivity

```bash
ssh -i ~/.ssh/mern-key ec2-user@<WEB_PUBLIC_IP>

ssh -i ~/.ssh/mern-key ec2-user@<MONGO_PRIVATE_IP>

ssh -i ~/.ssh/mern-key -J ec2-user@<WEB_PUBLIC_IP> ec2-user@<MONGO_PRIVATE_IP>
```

### Ansible

```bash
ansible all -i inventory.ini -m ping

ansible web -i inventory.ini -m ping

ansible mongodb -i inventory.ini -m ping

ansible-playbook -i inventory.ini web.yml

ansible-playbook -i inventory.ini mongodb.yml

ansible-playbook -i inventory.ini deploy.yml
```

<img width="1272" height="590" alt="Screenshot 2026-06-16 at 3 01 41 PM" src="https://github.com/user-attachments/assets/764532ee-e28c-4498-a021-0a4bc2c4d43d" />

<img width="1280" height="800" alt="Screenshot 2026-06-16 at 3 46 41 PM" src="https://github.com/user-attachments/assets/ccdf9b5a-7c39-46c7-ad28-7b1152e75ca4" />

<img width="1260" height="646" alt="Screenshot 2026-06-16 at 3 45 24 PM" src="https://github.com/user-attachments/assets/bbd20e79-743f-4a80-87cf-51e174999889" />

<img width="1280" height="492" alt="Screenshot 2026-06-16 at 2 59 04 PM" src="https://github.com/user-attachments/assets/cbba990b-e45b-4c95-9521-44b675d66a96" />


-----
### Linux Package Management (Amazon Linux 2023)

```bash
sudo dnf update -y

sudo dnf install git -y

sudo dnf install nodejs -y
```

### Git

```bash
git clone https://github.com/UnpredictablePrashant/TravelMemory.git

git status

git pull
```

### Node.js & NPM

```bash
npm install

npm start

npm run build

npm install -g pm2
```

### PM2 Process Management

```bash
pm2 start index.js --name travelmemory

pm2 start "npm start" --name travelmemory-ui

pm2 list

pm2 logs

pm2 logs travelmemory

pm2 logs travelmemory-ui

pm2 restart travelmemory

pm2 restart travelmemory-ui

pm2 delete travelmemory

pm2 delete travelmemory-ui

pm2 save
```

### Service Management

```bash
sudo systemctl status mongod

sudo systemctl start mongod

sudo systemctl restart mongod

sudo systemctl enable mongod
```

### Network Verification

```bash
curl http://localhost:3001/hello

curl http://localhost:3001/trip

ss -tulpn

ss -tulpn | grep 3000

ss -tulpn | grep 3001

ss -tulpn | grep 27017
```

### MongoDB Shell

```bash
mongosh

use travelmemory

show collections

db.trips.find()

db.trips.deleteMany({})

db.dropDatabase()
```

### Log Inspection

```bash
journalctl -u mongod -f

pm2 logs

tail -f ~/.pm2/logs/travelmemory-out.log

tail -f ~/.pm2/logs/travelmemory-error.log
```

-----

### Verification of the Assets Creation:

<img width="1280" height="800" alt="Screenshot 2026-06-16 at 1 42 18 PM" src="https://github.com/user-attachments/assets/6f7547fa-5129-424b-b0a7-7ff9a66ae525" />


<img width="1280" height="800" alt="Screenshot 2026-06-16 at 2 50 33 PM" src="https://github.com/user-attachments/assets/97be52da-6352-46c9-8695-e06cab2b869a" />


<img width="1278" height="699" alt="Screenshot 2026-06-16 at 11 58 10 PM" src="https://github.com/user-attachments/assets/d01a84ad-172c-4660-a479-d78902409178" />

<img width="1273" height="697" alt="Screenshot 2026-06-16 at 11 08 45 PM" src="https://github.com/user-attachments/assets/a896d7a5-d6de-47f0-b4a0-382e93480d51" />


<img width="1280" height="800" alt="Screenshot 2026-06-16 at 11 10 53 PM" src="https://github.com/user-attachments/assets/07293b70-48bf-4bc5-8260-ed2598f145c6" />

<img width="1280" height="800" alt="Screenshot 2026-06-16 at 10 43 41 PM" src="https://github.com/user-attachments/assets/deb861c3-a72b-446a-9fe3-ed5f499c45e8" />

<img width="1280" height="800" alt="Screenshot 2026-06-16 at 3 03 27 PM" src="https://github.com/user-attachments/assets/4747108c-f046-4860-ac79-bfabec6ad3f1" />


---

### SSH into the frontend and backend Servers

<img width="833" height="405" alt="Screenshot 2026-06-16 at 1 39 44 PM" src="https://github.com/user-attachments/assets/0e8d446e-5aac-4406-8923-78f54fdc28f7" />


<img width="1280" height="800" alt="Screenshot 2026-06-16 at 3 04 54 PM" src="https://github.com/user-attachments/assets/74ea72bb-8a4b-4179-9f83-098c9eace62b" />

-----

## Accessing the App on http://

<img width="1280" height="800" alt="Screenshot 2026-06-16 at 11 10 53 PM" src="https://github.com/user-attachments/assets/8ae6b88c-db7b-4b6c-a799-2daa6d4d6310" />

<img width="1271" height="695" alt="Screenshot 2026-06-16 at 3 52 32 PM" src="https://github.com/user-attachments/assets/5e901ab6-cb4a-47cd-9ebc-f9402f3a6774" />

<img width="1200" height="618" alt="Screenshot 2026-06-17 at 12 07 42 AM" src="https://github.com/user-attachments/assets/84b0fe89-4b25-42b0-8160-5718dcca2a07" />


<img width="1280" height="800" alt="Screenshot 2026-06-17 at 12 08 06 AM" src="https://github.com/user-attachments/assets/7f6adb4b-75fa-4a41-9f54-6ae898f93e49" />

<img width="1001" height="685" alt="Screenshot 2026-06-17 at 12 04 43 AM" src="https://github.com/user-attachments/assets/158a49ef-8cfc-45c2-a296-6d0596753721" />


----
## Terraform Destroy

Terraform provides a simple way to remove all provisioned infrastructure when it is no longer needed. The `terraform destroy` command automatically identifies and deletes all resources defined in the Terraform configuration, helping prevent unnecessary AWS costs and ensuring a clean environment.

```bash
terraform destroy
```

Before deleting resources, Terraform displays an execution plan showing which resources will be removed and requests confirmation. This makes infrastructure cleanup safe, predictable, and fully automated.


<img width="1280" height="800" alt="Screenshot 2026-06-17 at 12 13 56 AM" src="https://github.com/user-attachments/assets/e97100c1-1c69-4adb-a130-298cd8b24599" />

<img width="1096" height="675" alt="Screenshot 2026-06-17 at 12 15 45 AM" src="https://github.com/user-attachments/assets/afd73f2f-e943-44fa-b89f-9ebd0f2292c6" />


---

## Project Outcome

By combining Terraform and Ansible, the entire application stack can be provisioned, configured, and deployed automatically with minimal manual intervention. This approach improves scalability, reliability, reproducibility, and maintainability while aligning with industry-standard DevOps practices.

-----

### Author
**Saima Usman**
Jr. DevOps Engineer
HeroVired Batch-15

DevOps Project - AWS MERN Deployment by Saima Usman

