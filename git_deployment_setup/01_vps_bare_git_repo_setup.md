# VPS Bare Git Repository Setup for Deployment

To enable automated deployments via `git push`, a bare Git repository needs to be set up on the Azure VM. This repository will receive pushes from your local machine and trigger the `post-receive` deployment hook.

Run these commands on your Azure VM as your regular deployment user (e.g., `azureuser` or the user you created with sudo privileges).

## 1. Create the Bare Repository Directory

Choose a location for your bare repository. The user's home directory is a common choice.
```bash
cd ~ # Navigate to the home directory
mkdir my-website.git # Name of the bare repository (conventionally ends with .git)
cd my-website.git
```

## 2. Initialize the Bare Repositor
```bash
git init --bare
```

## 3. Configure for Pushing to the "Checked-Out" Branch
```bash
git config receive.denyCurrentBranch updateInstead
```

## 4. Prepare Deployment Directories
1. Source Checkout Directory: e.g., /var/www/my-hugo-source
```bash
sudo mkdir -p /var/www/my-hugo-source
sudo chown yourusername:yourusername /var/www/my-hugo-source # Replace yourusername
```
2. Nginx Webroot Directory: e.g., /var/www/html/my-blog
```bash
sudo mkdir -p /var/www/html/my-blog
sudo chown yourusername:yourusername /var/www/html/my-blog # Replace yourusername
```
