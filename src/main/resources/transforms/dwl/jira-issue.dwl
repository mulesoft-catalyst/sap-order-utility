%dw 2.0
output application/json
---
{
  
  summary: "API: Salesorder-uapi-- Order " ++ vars.operation  ++ " Failed for ---" ++ payload.ORDERS05.IDOC.E1EDK01.BELNR as String,
  description: error.detailedDescription as String,
  issuetype: p('jira-utility.issue-type'),
  priority: p('jira-utility.priority'),
  projectKey: p('jira-utility.project-key'),
  label: p('jira-utility.label')
}
