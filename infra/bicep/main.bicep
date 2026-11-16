targetScope = 'subscription'

@description('Short environment name used in resource names')
param env string = 'dev'
@description('Azure region')
param location string = 'centralindia'

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-steward-${env}'
  location: location
  tags: { project: 'steward', env: env }
}

module monitor 'modules/monitor.bicep' = { scope: rg, name: 'monitor'
  params: { env: env, location: location } }
// step 2 adds: identity, keyvault, postgres, servicebus, containerapps
