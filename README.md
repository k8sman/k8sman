# README for k8sman Installation and Overview

## Introduction

k8sman is an essential part of the k8sman platform, an open-source solution aimed at simplifying the management of private Kubernetes clusters without the need for VPNs. This README guides you through the installation process of k8sman and provides an overview of its architecture.

### k8sman Platform Components

Understanding the k8sman platform's components is crucial before proceeding with the installation:

1. **k8sman-agent**: Deployed within the Kubernetes cluster, it serves as a proxy to Kubernetes private APIs and monitors commands through a RabbitMQ queue.
2. **k8sman-helm-chart**: Provides the Helm chart for easy installation and configuration of k8sman in Kubernetes clusters.

## Installation of k8sman

The k8sman installation process is similar to that of Helm, using a Bash script from a URL. Follow these steps to install k8sman:

1. **Download the Installation Script**:
   Use the provided URL to download the installation script. For example:
   ```
   curl -fsSL -o get_k8sman.sh https://raw.githubusercontent.com/k8sman/k8sman/main/get_k8sman.sh
   ```

2. **Make the Script Executable**:
   ```
   chmod 700 get_k8sman.sh
   ```

3. **Execute the Installation Script**:
   ```
   ./get_k8sman.sh
   ```
   Alternatively, for a more direct approach:
   ```
   curl https://raw.githubusercontent.com/k8sman/k8sman/main/get_k8sman.sh | bash
   ```

## Post-Installation Steps

After installing k8sman, the following steps are recommended:

- **Install k8sman-agent**: Deploy k8sman-agent in your Kubernetes cluster. Installation instructions can be found in the `k8sman-agent` repository.
- **Use k8sman-helm-chart**: For setting up k8sman in your cluster efficiently, refer to the `k8sman-helm-chart` repository.
- **Consult k8sman-docs**: For comprehensive documentation and troubleshooting tips, visit the `k8sman-docs`.
- **Explore k8sman-examples**: To understand practical use cases and examples, check out `k8sman-examples`.

## Conclusion

k8sman is a robust tool that enhances Kubernetes cluster management when used in conjunction with other components of the k8sman platform. For further information and support, visit the [k8sman GitHub repository](https://github.com/k8sman/k8sman).
