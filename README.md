# GetActiveFwRules
Description: Get all Windows Firewall rules that are active due to the actual active network connection profiles

---
## Sample usage:
_$out = (Get-ActiveFirewallRules)_

_$out  | Out-GridView -Title "Total active Windows Firewall rules: $($out.count) / From active profiles: $($Global:ActiveProfiles -join ",")"_

