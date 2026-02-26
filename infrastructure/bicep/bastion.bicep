param location string
param bastionName string
param vnetName string

resource bastionPublicIP 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: '${bastionName}-pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' existing = {
  name: vnetName
}

resource bastion 'Microsoft.Network/bastionHosts@2023-05-01' = {
  name: bastionName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'bastion-ipconfig'
        properties: {
          subnet: {
            id: '${vnet.id}/subnets/AzureBastionSubnet'
          }
          publicIPAddress: {
            id: bastionPublicIP.id
          }
        }
      }
    ]
  }
}
