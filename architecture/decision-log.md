# Architecture Decision Log

This document captures key architectural decisions, constraints encountered, and rationale behind final design choices.

---

## AD-01: Region Selection Change

### Initial Plan
Deploy in North Europe.

### Issue
- VM SKU availability restrictions
- Capacity limits for B-series
- Quota limitations for DSv5 family

### Decision
Switch deployment to Sweden Central region.

### Rationale
- Better SKU availability
- Lower deployment friction
- Zone support aligned with lab objectives

---

## AD-02: VM Size Adaptation

### Initial Plan
Standard_B2s

### Issue
SKU not available in selected zone.

### Adjustment
Switched to Standard_B1s.

### Trade-off
- Lower CPU performance
- Sufficient for lab validation

---

## AD-03: SSH Key Misconfiguration

### Issue
Private key used instead of public key in Bicep template.

### Impact
Deployment failed with:
InvalidParameter: linuxConfiguration.ssh.publicKeys.keyData

### Resolution
Generated proper public key (.pub) and referenced it correctly.

### Lesson
Public key must be provided to ARM/Bicep. Private key remains local only.

---

## AD-04: NSG Rule Ordering

### Issue
Health probe succeeded but user traffic failed.

### Root Cause
NSG allowed AzureLoadBalancer traffic but not Internet traffic on port 80.

### Resolution
Added explicit inbound rule for TCP/80 with correct priority.

### Lesson
Health probe source ≠ Internet client source.

---

## AD-05: PropertyChangeNotAllowed Error

### Issue
Attempted to modify SSH configuration on existing VM.

### Resolution
VM must be recreated when changing SSH public keys.

### Lesson
Certain VM properties are immutable after creation.