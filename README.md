# Automated Hugo Deployment to Azure VM: Configuration & Scripts

This repository contains the configuration files, scripts, and documentation detailing the setup for automatically deploying a [Hugo](https://gohugo.io/) static site to an Nginx web server on an Azure Virtual Machine. It demonstrates a custom CI/CD pipeline built from scratch using server-side Git hooks.

This setup powers my personal blog, which can be viewed live at [http://X.X.X.X](http://X.X.X.X) (IP subject to change).
The source code for the Hugo site itself is located at [My-Blog](https://github.com/wusshit/My-Blog.git) 

## Purpose

The goal here is to document and share the DevOps practices implemented for this personal project, showcasing:
*   Server provisioning and initial setup on Azure.
*   Git-based CI/CD using a `post-receive` hook.
*   Automated static site building with Hugo.
*   Nginx configuration for serving the static site.

## High-Level Workflow Overview

1.  **Local Development:** Developer writes Hugo site content and pushes changes to a primary Git remote (e.g., GitHub).
2.  **Deployment Trigger:** To deploy, the developer pushes to a *separate* Git remote (`vps-deploy`) pointing to a bare Git repository on the Azure VM.
3.  **Server-Side Automation:** This push triggers a `post-receive` hook script within the bare repository on the server.
4.  **Build & Deploy Process (by hook script):**
    *   The latest source code is checked out.
    *   Hugo builds the static site (`public/` directory).
    *   The live webroot for Nginx is cleared.
    *   The newly built `public/` directory contents are copied to the Nginx webroot.
5.  **Site Live:** Nginx serves the updated website.

## Repository Structure

This repository is organized as follows:

*   **/server_preparation/**: Notes and example commands for setting up the Azure VM.
    *   `01_azure_vm_provisioning_notes.md`: Key considerations during VM creation in Azure.
    *   `02_initial_os_configuration.md`: Steps for OS updates, user management, and firewall (NSG).
    *   `03_software_installation.md`: Commands for installing Git, Nginx, and Hugo.
*   **/git_deployment_setup/**: Scripts and notes related to the Git-based deployment mechanism.
    *   `01_vps_bare_git_repo_setup.md`: Setting up the server-side bare Git repository for deployment.
    *   `02_post-receive_hook.sh`: The core deployment automation script (the `post-receive` hook).
*   **/nginx_configuration/**: Nginx configuration files.
    *   `my_blog_nginx.conf`: The Nginx server block configuration for the Hugo site.

## Future Enhancements for This Setup

*   Add more functionalities provided by Nginx
*   Implement HTTPS
*   Automate server provisioning and configuration using Ansible.
*   Explore containerizing the application/build process with Docker.
*   Set up monitoring and more robust logging.

Please browse the respective directories for detailed configurations and scripts.
