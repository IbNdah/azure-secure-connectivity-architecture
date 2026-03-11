# Traffic Flow Diagram

```mermaid
sequenceDiagram

participant User
participant LB as Public Load Balancer
participant VM1
participant VM2

User->>LB: HTTP Request
LB->>VM1: Forward if healthy
LB->>VM2: Forward if healthy
VM1-->>LB: Response
VM2-->>LB: Response
LB-->>User: HTTP Response