# Logical Architecture Diagram

```mermaid
flowchart TB

Internet((Internet))

LB[Public Load Balancer]
Probe[Health Probe TCP/80]

subgraph VNet[vnet-secure-se]
    subgraph AppSubnet[snet-app-se]
        VM1[VM Zone 1\nNGINX]
        VM2[VM Zone 2\nNGINX]
    end
    
    subgraph BastionSubnet[AzureBastionSubnet]
        Bastion[Azure Bastion]
    end
end

Internet --> LB
LB --> VM1
LB --> VM2
LB --> Probe

User((Admin User)) --> Bastion
Bastion --> VM1
Bastion --> VM2