# Troubleshooting Log

## Deployment Failures

### Error: SkuNotAvailable
Cause:
Requested VM size unavailable in selected zone.

Resolution:
Check availability using:
az vm list-skus --location swedencentral --output table

---

### Error: QuotaExceeded
Cause:
Subscription core quota limit reached.

Resolution:
- Select lower SKU
- Or request quota increase

---

### Error: Circular Dependency
Cause:
Subnet and NSG incorrectly referencing each other.

Resolution:
Refactored module dependency order.

---

### Error: SSH Authentication Failed
Cause:
Incorrect key reference in deployment.

Resolution:
Use:
Get-Content $env:USERPROFILE\.ssh\id_rsa.pub