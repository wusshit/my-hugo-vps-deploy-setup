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

## 2. User Management ( If you need to create an additional user )
```bash
sudo adduser newadminuser
sudo usermod -aG sudo newadminuser
```

## 3. Firewall Configuration (Azure Network Security Group - NSG)

Follow these steps to configure the necessary inbound port rules for your Azure Virtual Machine.

1.  **Navigate to your Virtual Machine** in the Azure portal.
2.  Go to **Settings** -> **Networking**.
3.  Under **Inbound port rules**, ensure the following rules exist (or add them if they don't):

    ---
    **Rule 1 (SSH)**
    *   **Priority:** e.g., `100`
    *   **Name:** `Allow-SSH`
    *   **Port:** `22`
    *   **Protocol:** `TCP`
    *   **Source:** `Any` (or preferably, *your specific IP address/range for enhanced security*)
    *   **Destination:** `Any`
    *   **Action:** `Allow`

    ---
    **Rule 2 (HTTP)**
    *   **Priority:** e.g., `110`
    *   **Name:** `Allow-HTTP`
    *   **Port:** `80`
    *   **Protocol:** `TCP`
    *   **Source:** `Any` (or `Internet`)
    *   **Destination:** `Any`
    *   **Action:** `Allow`

    ---
    **Rule 3 (HTTPS - for future use)**
    *   **Priority:** e.g., `120`
    *   **Name:** `Allow-HTTPS`
    *   **Port:** `443`
    *   **Protocol:** `TCP`
    *   **Source:** `Any` (or `Internet`)
    *   **Destination:** `Any`
    *   **Action:** `Allow`

    ---

## 4. (Optional) Secure SSH Further
```bash
sudo vim /etc/ssh/sshd_config
```
Consider setting/ensuring:

*   `PasswordAuthentication no` (if using SSH keys exclusively)
*   `PermitRootLogin no`

After changes, restart the SSH service:
`sudo systemctl restart sshd`

Caution: Ensure your SSH key login works before disabling password authentication, or you might lock yourself out.
