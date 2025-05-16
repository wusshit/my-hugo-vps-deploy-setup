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
