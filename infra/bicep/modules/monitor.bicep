param env string
param location string

// Log Analytics workspace; step 2 adds the 30-day retention, daily cap and App Insights
resource law 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: 'log-steward-${env}'
  location: location
  properties: {
    sku: { name: 'PerGB2018' }
    retentionInDays: 30
    workspaceCapping: { dailyQuotaGb: json('0.5') }   // a logging bug cannot cost money
  }
}

output workspaceId string = law.id
