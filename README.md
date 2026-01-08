Remote Multi-OS Web Server Deployment Using Bash
📌 Project Overview

This project demonstrates remote automation using Bash scripting where an Ubuntu controller machine (ubuntu2) pushes and executes scripts on multiple Linux servers with different operating systems.

The controller:

Pushes a script using scp

Executes it remotely using ssh

Detects OS type (Ubuntu / CentOS)

Installs the correct web server

Deploys a static website automatically

This project represents pre-Ansible style automation and builds strong fundamentals for DevOps engineers.

🧱 Infrastructure Used
Role	Hostname	OS
Controller	ubuntu2	Ubuntu
Web Server 1	vm1	Ubuntu
Web Server 2	vm2	CentOS
             ┌────────────────┐
             │   ubuntu2      │
             │ (Controller)   │
             └───────┬────────┘
                     │ SSH / SCP
           ┌─────────┴─────────┐
           │                   │
     ┌─────▼─────┐       ┌─────▼─────┐
     │   vm1     │       │   vm2     │
     │ (Ubuntu)  │       │ (CentOS)  │
     └───────────┘       └───────────┘

⚙️ Prerequisites

SSH enabled on all machines

Internet access

devops user with sudo privileges on vm1 and vm2

🔧 Initial Setup
1️⃣ Set Hostnames (if not already set)
sudo hostnamectl set-hostname ubuntu2   # controller
sudo hostnamectl set-hostname vm1       # ubuntu web
sudo hostnamectl set-hostname vm2       # centos web

2️⃣ Configure /etc/hosts on ubuntu2
sudo vi /etc/hosts


Example:

192.168.56.101 vm1
192.168.56.102 vm2


Test:

ping vm1
ping vm2

3️⃣ Create devops User on Target Machines

Run on vm1 and vm2:

sudo useradd devops
sudo passwd devops


Add sudo permission:

sudo visudo


Add:

devops ALL=(ALL) NOPASSWD:ALL

4️⃣ Enable Password Authentication (Ubuntu only – vm1)
sudo vi /etc/ssh/sshd_config


Set:

PasswordAuthentication yes


Restart SSH:

sudo systemctl restart ssh

5️⃣ Configure SSH Key-Based Login (Recommended)

On ubuntu2:

ssh-keygen
ssh-copy-id devops@vm1
ssh-copy-id devops@vm2


Test:

ssh devops@vm1 hostname
ssh devops@vm2 hostname

📁 Project Structure
remote_websetup/
├── multios_websetup.sh
├── remote_websetup.sh
├── remotehosts

📄 Script Files (FINAL VERSIONS)
📄 remotehosts
vm1
vm2

📄 remote_websetup.sh

▶️ How to Run the Project

On ubuntu2:

./remote_websetup.sh

🌐 Verify Deployment

Open browser:

http://<vm1-ip>
http://<vm2-ip>
