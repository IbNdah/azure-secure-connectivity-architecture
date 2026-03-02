targetScope = 'subscription'

@description('Deployment region')
param location string = 'swedencentral'

@description('Resource Group name')
param rgName string = 'rg-secure-connectivity-se'

@description('Virtual Network name')
param vnetName string = 'vnet-secure-se'

@description('Application subnet name')
param appSubnetName string = 'snet-app-se'

@description('Bastion subnet name')
param bastionSubnetName string = 'AzureBastionSubnet'

@description('Network Security Group name')
param nsgName string = 'nsg-app-se'

@description('Admin username')
param adminUsername string = 'azureuser'

@description('SSH public key')
param sshPublicKey string

@description('VM size')
param vmSize string = 'Standard_B1s'

@description('VM instances definition')
param vmInstances array = [
  {
    name: 'vm-app-se-01'
    zone: '1'
  }
  {
    name: 'vm-app-se-02'
    zone: '2'
  }
]

/* --------------------------------------------------
   Resource Group
--------------------------------------------------- */

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgName
  location: location
}

/* --------------------------------------------------
   NSG
--------------------------------------------------- */

module nsgModule './nsg.bicep' = {
  name: 'nsgDeployment'
  scope: rg
  params: {
    location: location
    nsgName: nsgName
  }
}

/* --------------------------------------------------
   VNet + Subnets
--------------------------------------------------- */

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

/* --------------------------------------------------
   Virtual Machines (loop)
--------------------------------------------------- */

module vmModule './vm.bicep' = [for vm in vmInstances: {
  name: 'vmDeployment-${vm.name}'
  scope: rg
  dependsOn: [
    vnetModule
  ]
  params: {
    location: location
    vmName: vm.name
    vnetName: vnetName
    appSubnetName: appSubnetName
    sshPublicKey: sshPublicKey
    zone: vm.zone
    adminUsername: adminUsername
    vmSize: vmSize
  }
}]

/* --------------------------------------------------
   Bastion
--------------------------------------------------- */

module bastionModule './bastion.bicep' = {
  name: 'bastionDeployment'
  scope: rg
  dependsOn: [
    vnetModule
  ]
  params: {
    location: location
    bastionName: 'bas-secure-se'
    vnetName: vnetName
  }
}

/* --------------------------------------------------
   Load Balancer
--------------------------------------------------- */

module lbModule './loadbalancer.bicep' = {
  name: 'lbDeployment'
  scope: rg
  dependsOn: [
    vmModule
  ]
  params: {
    location: location
    lbName: 'lb-app-se'
    vnetName: vnetName
    appSubnetName: appSubnetName
    vmNames: [for vm in vmInstances: vm.name]
  }
}
