# TravelMemory MERN Stack Deployment on AWS (Terraform + Ansible)

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

```bash
Laptop
|
| SSH
v
EC2 Bastion / Web Server (Public Subnet)
|
| Private Network
v
EC2 MongoDB Server (Private Subnet)
```
---

## 🏗 Architecture

```mermaid
graph TD

User[User / Browser]

subgraph AWS_VPC[VPC - AWS Cloud]
    
    subgraph PublicSubnet[Public Subnet]
        WebEC2[EC2 - Web Server<br/>React + Node + PM2]
    end

    subgraph PrivateSubnet[Private Subnet]
        MongoEC2[EC2 - MongoDB Server]
    end

    IGW[Internet Gateway]
    NAT[NAT Gateway]

end

User --> IGW
IGW --> WebEC2

WebEC2 -->|API Calls :3001| MongoEC2

WebEC2 --> NAT
NAT --> MongoEC2

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

---

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

---

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
---



















----

### Author
**Saima Usman**
Jr. DevOps Engineer

DevOps Project - AWS MERN Deployment

