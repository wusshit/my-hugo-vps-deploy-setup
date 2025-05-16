# My Personal Website & Blog

**Live Site:** [http://4.180.169.137](http://4.180.169.137)
*(Note: This IP may change. A custom domain and HTTPS are planned future improvements.)*

Welcome to the source code repository for my personal website and blog! This site is built using the static site generator [Hugo](https://gohugo.io/) and is a space where I share my journey learning new technologies and various interests.

Beyond the content itself, this project also serves as a practical learning ground for implementing DevOps principles and building an automated deployment pipeline for a self-managed server.

## About This Site

*   **Content:** Blog posts, articles, and pages written in Markdown.
*   **Static Site Generator:** Hugo (Currently using the 'hugo-profile' theme, after migrating from 'ananke').
*   **Deployment:** This site is automatically built and deployed to a self-managed Azure Virtual Machine running Nginx.

## DevOps & CI/CD Demonstration

The operational setup that powers this site – including the CI/CD pipeline, server configuration, Nginx setup, and custom Git hooks – is documented in detail in a separate repository:

👉 **[View Detailed CI/CD Setup & Configuration Files](https://github.com/[YourGitHubUsername]/my-hugo-vps-deploy-setup)** 👈

This "configuration demo" repository includes:
*   The exact `post-receive` Git hook script used for automation.
*   The Nginx server block configuration.
*   Notes on the Azure VM setup and other server-side configurations.
*   A detailed explanation of the deployment workflow.

This separation helps keep this repository focused on the site's content and the other repository focused on the operational infrastructure.

## Technologies Used (Site Content - This Repo)

*   **Static Site Generation:** Hugo
*   **Content Management:** Markdown, Git
*   **Version Control:** Git & GitHub

*(For technologies related to deployment, server, and CI/CD, please see the [CI/CD Setup & Configuration Repository](https://github.com/[YourGitHubUsername]/my-hugo-vps-deploy-setup).)*

## Local Development

To run or contribute to the content of this site locally:

1.  Clone this repository:
    ```bash
    git clone https://github.com/[YourGitHubUsername]/my-blog.git # Adjust repo name if different
    ```
2.  Navigate into the project directory:
    ```bash
    cd my-blog # Adjust repo name if different
    ```
3.  Ensure you have [Hugo (Extended version)](https://gohugo.io/installation/) installed.
4.  If the theme is managed as a Git submodule (e.g., `hugo-profile`):
    ```bash
    git submodule update --init --recursive
    ```
5.  Run the local Hugo server:
    ```bash
    hugo server -D
    ```
    The site will typically be available at `http://localhost:1313`.

## How to Deploy (Overview)

Updates to this site are deployed via a `git push` to a specific remote on my Azure VM. The server then automatically builds and deploys the latest version.

1.  Commit local changes to this repository.
2.  Push to `origin` (GitHub).
3.  Push to the `vps-deploy` remote to trigger the live deployment.

## Future Plans

I plan to continue developing both the content of this blog and enhancing its underlying infrastructure:

*   Adding more articles and sharing my learning experiences.
*   Implementing a custom domain and HTTPS (SSL/TLS).
*   Further exploring DevOps tools for automation, configuration management (e.g., Ansible), and containerization (e.g., Docker). *(Refer to the [CI/CD Setup & Configuration Repository](https://github.com/[YourGitHubUsername]/my-hugo-vps-deploy-setup) for more specific infrastructure plans.)*

---

Thank you for visiting!
