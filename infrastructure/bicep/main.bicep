targetScope = 'subscription'

param location string = 'northeurope'
param rgName string = 'rg-secure-connectivity-ne'
param vnetName string = 'vnet-secure-ne'
param appSubnetName string = 'snet-app-ne'
param bastionSubnetName string = 'AzureBastionSubnet'
param nsgName string = 'nsg-app-ne'
param vmName string = 'vm-app-ne-01'
param sshPublicKey string
param bastionName string = 'bas-secure-ne'

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgName
  location: location
}

module nsgModule './nsg.bicep' = {
  name: 'nsgDeployment'
  scope: rg
  params: {
    location: location
    nsgName: nsgName
  }
}

module vnetModule './vnet.bicep' = {
  name: 'vnetDeployment'
  scope: rg
  dependsOn: [
    nsgModule
  ]
  params: {
    location: location
    vnetName: vnetName
    appSubnetName: appSubnetName
    bastionSubnetName: bastionSubnetName
    nsgId: nsgModule.outputs.nsgId
  }
  
}

module vmModule './vm.bicep' = {
  name: 'vmDeployment'
  scope: rg
  dependsOn: [
    vnetModule
  ]
  params: {
    location: location
    vmName: vmName
    vnetName: vnetName
    appSubnetName: appSubnetName
    sshPublicKey: sshPublicKey
  }
}

module bastionModule './bastion.bicep' = {
  name: 'bastionDeployment'
  scope: rg
  dependsOn: [
    vnetModule
  ]
  params: {
    location: location
    bastionName: bastionName
    vnetName: vnetName
  }
}
