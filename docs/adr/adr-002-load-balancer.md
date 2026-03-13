# ADR-002: Layer 4 Traffic Distribution using Azure Load Balancer

## Status

Accepted

---

## Context

Applications deployed across multiple virtual machines require a mechanism to distribute incoming traffic and provide high availability.

Without a load balancing mechanism:

* traffic would be directed to a single VM
* failure of that VM would result in service disruption
* scaling the application would be difficult

The architecture requires a simple and reliable method for distributing incoming requests across backend virtual machines.

---

## Decision

The architecture uses **Azure Load Balancer (Standard SKU)** to distribute incoming traffic across backend virtual machines.

The Load Balancer acts as the single public entry point for the application.

Traffic distribution is based on Layer 4 (TCP) load balancing.

A health probe monitors backend VM availability to ensure traffic is only routed to healthy instances.

---

## Consequences

### Advantages

* High-performance Layer 4 traffic distribution
* Simple architecture
* High availability across multiple backend instances
* Automatic failover through health probes
* Scalable backend pool

### Trade-offs

* No Layer 7 routing capabilities
* No integrated Web Application Firewall (WAF)
* No TLS termination

---

## Alternatives Considered

### Azure Application Gateway

Provides:

* Layer 7 routing
* TLS termination
* Web Application Firewall

Not selected for this architecture because the objective of this project is to demonstrate **infrastructure-level load balancing and high availability** rather than advanced application routing.

Future improvements may include introducing Application Gateway for Layer 7 security.
