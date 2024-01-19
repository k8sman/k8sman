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

### Starting the Local Server and Connecting to a Cluster

To connect to a specific Kubernetes cluster, use the `connect` command:

```sh
k8sman connection connect <cluster-name>
```

Replace `<cluster-name>` with the name of your Kubernetes cluster. This command initializes a local HTTP server that interacts with the `k8sman-agent` and creates a `kubeconfig` file in your user's `.kube` directory. This file is necessary for `kubectl` to communicate with the Kubernetes cluster through the `k8sman`.

## Configuration Attributes

The following table lists the configurable attributes for `k8sman` and their descriptions. For a basic initial setup, it is necessary to configure only `rabbitmq-host`, `rabbitmq-user`, `rabbitmq-pass`, and `rabbitmq-vhost`. The other attributes can be left at their default values unless specific changes are needed.

| Attribute            | Description                                           | Example Value                  |
|----------------------|-------------------------------------------------------|--------------------------------|
| `rabbitmq-host`      | Host of the RabbitMQ server                           | `<host>`                       |
| `rabbitmq-user`      | Username for RabbitMQ                                 | `<user>`                       |
| `rabbitmq-pass`      | Password for RabbitMQ                                 | `<password>`                   |
| `rabbitmq-vhost`     | Virtual Host for RabbitMQ                             | `<vhost>`                      |
| `queue-commands`     | Name of the commands queue in RabbitMQ                | `commands` (default)           |
| `queue-responses`    | Name of the responses queue in RabbitMQ               | `responses` (default)          |
| `enable-tls`         | Enable TLS for secure communication                   | `true` (default)               |
| `rabbitmq-tls-port`  | TLS port of the RabbitMQ server                       | `5671` (default for cloud services) |

To configure these attributes, use the `config` command followed by the specific flags. For example:

```sh
k8sman connection create <name> \
    --rabbitmq-host <host> \
    --rabbitmq-user <user> \
    --rabbitmq-pass <pass> \
    --rabbitmq-vhost <vhost> \
    --secret <secret> 

```

Note: The TLS port `5671` is commonly used for cloud-based RabbitMQ services, but it might vary based on your specific RabbitMQ setup. The default values for `queue-commands`, `queue-responses`, and `enable-tls` are typically suitable for most configurations.

## All Commands

### Connect to a Cluster
```
k8sman connection connect <name>
```
- Description: Initializes a local server and connects to a specified Kubernetes cluster, generating a `kubeconfig` file for seamless integration with `kubectl`.

### Create a New Connection
```
k8sman connection create <name> \
    --rabbitmq-host <host> \
    --rabbitmq-user <user> \
    --rabbitmq-pass <pass> \
    --rabbitmq-vhost <vhost> \
    --secret <secret>
```
- Description: Creates a new connection with a specified agent, configuring connection details such as RabbitMQ host, user, password, virtual host, and secret.

### Update an Existing Connection
```
k8sman connection update <name> [...]
```
- Description: Updates an existing connection with a specified agent, allowing changes to settings such as RabbitMQ host, user, password, virtual host, secret, etc.

### Delete a Connection
```
k8sman connection delete <name>
```
- Description: Deletes an existing connection with a specified agent, removing it from the configuration file.

### List Available Connections
```
k8sman connection list
```
- Description: Lists all available connection configurations, displaying agent names and their associated settings.
