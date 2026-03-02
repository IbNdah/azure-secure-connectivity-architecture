# Azure Secure Connectivity & High Availability Architecture

## 🎯 Executive Summary

This project demonstrates the design and deployment of a secure and highly available Azure infrastructure using:

- Virtual Network segmentation
- Network Security Groups
- Azure Bastion
- Standard Public Load Balancer
- Multi-zone Linux Virtual Machines
- Infrastructure as Code (Bicep)

The goal is to demonstrate enterprise-grade connectivity design, traffic isolation, and availability strategy.

---

## 🏗 Architecture Overview

### Components

- Resource Group: `rg-secure-connectivity-se`
- Region: Sweden Central
- Virtual Network: `vnet-secure-se`
- Subnets:
  - `snet-app-se`
  - `AzureBastionSubnet`
- Network Security Group: `nsg-app-se`
- Azure Bastion
- Standard Public Load Balancer
- 2 Linux VMs deployed in different Availability Zones
- NGINX installed for traffic validation

---

## 🧠 Architectural Design Principles

- Zero Trust access model
- Minimized attack surface
- Layered security controls
- Zone redundancy
- Traffic inspection through Load Balancer
- Infrastructure as Code

---

## 🌐 Traffic Flow

Internet → Public Load Balancer → Backend Pool → VM (Zone 1 / Zone 2)

SSH Access:
User → Azure Bastion → VM (Private IP only)

---

## 🔐 Security Posture

### Inbound Exposure

- No Public IP attached to VMs
- SSH only accessible via Bastion
- NSG restricts direct inbound traffic
- Azure Load Balancer health probe monitored

### Isolation Layers

1. Subnet-level segmentation
2. NSG filtering
3. Bastion controlled access
4. Zone distribution for resilience

---

## ⚖ Trade-offs

| Decision | Benefit | Risk |
|----------|----------|------|
| Standard LB | High availability | Slightly higher cost |
| Bastion | No SSH exposed | Added complexity |
| Multi-Zone | Resilience | Region quota dependency |

---

## 🧪 Validation Steps

- Confirm health probe state
- Stop nginx on one VM
- Validate traffic shifts to second VM
- Confirm no direct SSH from internet
- Confirm Bastion-only access

---

## 🚀 Future Improvements

- Add Azure Application Gateway (WAF)
- Implement Private Endpoint services
- Integrate Azure Monitor + Log Analytics
- Enable Defender for Cloud
- Introduce autoscaling

---

## 📚 Key Learnings

- NSG rule priority impacts traffic behavior
- Health probe ≠ user traffic path
- Load Balancer isolation layer is critical
- Bastion reduces exposed attack vectors
- Zone awareness impacts design choices
