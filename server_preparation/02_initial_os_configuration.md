# Initial OS Configuration on Azure VM

After the Azure VM is provisioned and you can connect via SSH (`ssh -i /your_file's_actual_location/key_pair.pem yourusername@YOUR_VM_PUBLIC_IP`).

## 1. System Updates

It's crucial to update all system packages immediately after the first login.
```bash
sudo apt update
sudo apt list --upgradable
sudo apt upgrade -y
# A reboot might be necessary if a new kernel was installed:
# sudo reboot
```

## 2. User Management

Azure typically creates a default admin user with sudo privileges (e.g., azureuser). If you need to create an additional user or modify this:
### To verify current user and groups:
```bash
whoami
groups
```
### To create a new user (if needed):
```bash
sudo adduser newadminuser
sudo usermod -aG sudo newadminuser
```
