# ADR-001: Secure Administrative Access via Azure Bastion

## Status

Accepted

---

## Context

Direct SSH access to virtual machines through public IP addresses significantly increases the attack surface of cloud infrastructure.

Common risks include:

* brute-force attacks on port 22
* credential compromise
* automated scanning of publicly exposed services
* uncontrolled administrative entry points

In production environments, administrative access should be centralized and protected.

---

## Decision

Administrative access to virtual machines will be performed using **Azure Bastion**.

Azure Bastion provides secure browser-based SSH and RDP connectivity over HTTPS (port 443) without requiring public IP addresses on the virtual machines.

The Bastion service is deployed inside a dedicated subnet (`AzureBastionSubnet`) within the virtual network.

---

## Consequences

### Advantages

* No public IP address required on virtual machines
* Reduced external attack surface
* Centralized administrative access
* Encrypted connection over HTTPS
* Alignment with Zero Trust principles

### Trade-offs

* Additional infrastructure cost
* Dedicated subnet required for Bastion deployment
* Slightly increased operational complexity

---

## Alternatives Considered

### Public SSH Access

Rejected due to:

* exposed management ports
* higher attack surface
* increased risk of brute-force attacks

### VPN Gateway Access

Considered but not selected for this architecture because:

* additional network complexity
* Bastion provides simpler secure access for this scenario
