# Azure VM Provisioning Notes

These are general notes and considerations taken when provisioning the Azure Virtual Machine for hosting the Hugo blog.

## VM Creation Choices (via Azure Portal)

*   **Subscription:** An active Azure subscription.
*   **Resource Group:** A new or existing resource group (e.g., `hugo-blog-rg`) to organize all related resources.
*   **Virtual Machine Name:** A descriptive name (e.g., `hugo-vps`).
*   **Region:** Choose a region geographically close to your target audience or yourself for lower latency.
*   **Availability Options:** "No infrastructure redundancy required" is typically sufficient for a personal blog.
*   **Security Type:** "Standard."
*   **Image (Operating System):** **Ubuntu Server 22.04 LTS** (or your chosen LTS version, e.g., 20.04 LTS). Gen2 x64 images are common.
*   **Size:** A small, cost-effective size like **B1s** (1 vCPU, 1 GiB RAM) is usually adequate for a low-traffic Hugo site served by Nginx.
*   **Authentication Type:** **SSH public key.** This is more secure than password authentication.
    *   Ensure your public SSH key is added during VM creation.
*   **Username:** A standard admin username (e.g., `azureuser` or your preferred name).

## Disks

*   **OS Disk Type:** "Standard SSD" provides a good balance of performance and cost.

## Networking

*   **Virtual Network/Subnet:** Defaults are usually fine, or Azure will create new ones.
*   **Public IP Address:**
    *   A new Public IP will be created. Initially, this can be "Dynamic."
    *   For a stable live site, consider changing it to "Static" later (may incur a small cost). Note down this IP.
*   **NIC Network Security Group (NSG):** "Basic." This is where firewall rules are primarily managed.
    *   **Crucial Initial Inbound Port Rule:** Ensure **SSH (port 22, TCP)** is allowed (preferably from your specific IP for security, or "Any" if your IP changes often).
    *   Other ports (HTTP/80, HTTPS/443) will be opened via NSG rules later.

*Remember to download and securely store your private SSH key if Azure generates a new key pair for you.*
