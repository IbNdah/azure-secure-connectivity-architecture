# ADR-003: High Availability using Availability Zones

## Status

Accepted

---

## Context

Cloud infrastructure must remain resilient to infrastructure failures such as:

* datacenter outages
* hardware failures
* network disruptions within a single zone

Deploying all resources in a single availability zone introduces a single point of failure.

To improve resilience, workloads should be distributed across independent failure domains.

---

## Decision

The virtual machines hosting the application are deployed across **multiple Azure Availability Zones**.

Each VM instance resides in a separate zone to reduce the impact of localized infrastructure failures.

Traffic distribution across zones is handled by the Azure Load Balancer.

---

## Consequences

### Advantages

* Increased resilience against datacenter failures
* Improved service availability
* Fault isolation across zones
* Alignment with cloud high availability best practices

### Trade-offs

* Slightly increased infrastructure complexity
* Potential cross-zone data transfer costs

---

## Alternatives Considered

### Single Zone Deployment

Rejected due to the higher risk of service disruption in case of zone-level failures.

### Availability Sets

Availability Sets provide fault and update domain separation but do not protect against datacenter-level failures.

Availability Zones provide stronger isolation and were therefore preferred.
