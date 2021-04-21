%dw 2.0
output application/json
---
{
  
  summary: "API: Salesorder-uapi-- OBO order update to SAP failed for " ++ payload.ORDERS05.IDOC.E1EDK01.BELNR as String,
  description: vars.errorMsg as String,
  issuetype: p('jira-utility.issue-type'),
  priority: p('jira-utility.priority'),
  projectKey: p('jira-utility.project-key'),
  label: p('jira-utility.label')
}