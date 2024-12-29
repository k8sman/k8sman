# K8sman CLI - Complete User Guide

## Introduction

K8sman is a professional-grade command-line interface (CLI) designed for managing Kubernetes clusters securely and efficiently. It eliminates the need for a VPN by routing Kubernetes traffic through a secure proxy, giving you complete control over access to private clusters. K8sman also includes robust auditing and compliance features—ensuring that every cluster action is tracked and traceable, making it easier to meet regulatory requirements.

**Key Benefits**  
- **No VPN Required**: Access private clusters through a fully managed proxy layer.  
- **Security & Compliance**: Secure authentication methods, token-based context management, and detailed audit logs to meet compliance standards.  
- **Simplified Cluster Management**: Manage multiple Kubernetes contexts and switch seamlessly between them.  
- **Full Control**: Granular access controls let you define who can access which clusters, along with secure credential storage.

---

## Installation

### Steps to Install

1. **Download the Installation Script:**
   ```bash
   curl -fsSL -o get_k8sman.sh https://raw.githubusercontent.com/k8sman/k8sman/main/get_k8sman.sh
   ```

2. **Make the Script Executable:**
   ```bash
   chmod 700 get_k8sman.sh
   ```

3. **Run the Installation Script:**
   ```bash
   ./get_k8sman.sh
   ```
   Or run it directly from the URL:
   ```bash
   curl https://raw.githubusercontent.com/k8sman/k8sman/main/get_k8sman.sh | bash
   ```

### Verify Installation

After installing, verify that K8sman is installed correctly:
```bash
k8sman --version
```

---

## Key Commands and Features

### 1. Authentication

#### **Login**

Use `k8sman login` to authenticate, store your credentials locally, and ensure secure, compliant access:

```bash
k8sman login
```

When you run this command:
- It opens your default browser.
- Redirects you to the K8sman login page (supports Single Sign-On and other methods).
- Stores a secure token on your machine after successful authentication.

### 2. Context Management

#### **Add a Context**

Add a new Kubernetes context via:

```bash
k8sman context add \
    --token <token> \
    --api-server <api-server-url> \
    [--cluster <cluster-name>]
```

- **--token** (Required): The cluster access token.  
- **--api-server**: The Kubernetes API server URL (uses the proxy server URL if omitted).  
- **--cluster**: An optional custom name for the cluster. If provided, it becomes your active context.

---

## Example Workflow

1. **Log In to the Platform:**  
   ```bash
   k8sman login
   ```

2. **Add a Context for Your Cluster:**  
   ```bash
   k8sman context add --token C983...TAHwo8Q --cluster my-cluster-1
   ```

---

## Configuration

### Environment Variables

You can customize K8sman using environment variables:

| Variable            | Default Value             | Description                                    |
| ------------------- | ------------------------- | ---------------------------------------------- |
| `PORT`              | `5269`                    | Port for local authentication callbacks        |
| `AUTHENTICATOR_URL` | `https://app.k8sman.io`   | URL for the authenticator service              |
| `PROXY_SERVER_URL`  | `https://proxy.k8sman.io` | URL for the Kubernetes API proxy               |

### Customizing Configuration

Override these defaults by exporting variables or using a `.env` file:
```bash
export PORT=8080
export AUTHENTICATOR_URL=https://custom-auth.url
export PROXY_SERVER_URL=https://custom-proxy.url
```

---

## Licensing

K8sman is proprietary software and requires a valid subscription to use. For details, please contact K8sman support or consult your subscription agreement.

---

## Learn More

For additional resources, updates, and in-depth documentation, visit:

[K8sman.io](https://k8sman.io)

