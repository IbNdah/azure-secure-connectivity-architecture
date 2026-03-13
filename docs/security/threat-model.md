# Threat Model

## Overview

This document identifies potential security threats affecting the Azure infrastructure and describes the mitigation strategies implemented in the architecture.

The objective is to reduce the attack surface and implement a defense-in-depth strategy.

---

## Potential Threats and Mitigations

| Threat               | Description                                | Mitigation                                    |
| -------------------- | ------------------------------------------ | --------------------------------------------- |
| Brute Force SSH      | Attackers attempt to guess SSH credentials | No public SSH exposure, Bastion access only   |
| Port Scanning        | Automated scanning of exposed services     | Only Load Balancer public IP exposed          |
| VM Compromise        | Exploitation of vulnerable VM services     | Network segmentation with subnets and NSGs    |
| Lateral Movement     | Attackers moving between resources         | Segmented subnets and restricted access paths |
| Datacenter Failure   | Failure of a single availability zone      | Multi-zone deployment                         |
| Traffic Interception | Unencrypted HTTP traffic interception      | Future improvement: TLS termination           |

---

## Attack Surface Summary

| Component        | Exposure Level          |
| ---------------- | ----------------------- |
| Load Balancer    | Public endpoint         |
| Azure Bastion    | Public endpoint (HTTPS) |
| Virtual Machines | Private only            |

---

## Residual Risks

Despite implemented controls, some risks remain:

* HTTP traffic is currently unencrypted
* No Web Application Firewall (WAF)
* No centralized security monitoring
* No DDoS protection plan enabled

---

## Future Security Enhancements

Planned improvements include:

* HTTPS with TLS termination
* Azure Application Gateway with WAF
* Azure DDoS Protection Standard
* Azure Monitor and Log Analytics
* Microsoft Defender for Cloud
