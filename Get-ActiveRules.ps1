# Helper Function to get active Connection profiles
Function Get-ConnectionProfiles {

    $ActiveFWProfiles = (Get-NetConnectionProfile).NetworkCategory 
    $MyActiveProfiles = @()
    Foreach ($Profile in $ActiveFWProfiles) {
        if ($Profile -like "Domain*") {
            $MyActiveProfiles += "Domain"
        }
        else {
            $MyActiveProfiles += $Profile
        }
    }
    return $MyActiveProfiles
}
# retrieve all active firewall rules corresponding to the active connection profiles of the Windows FIrewall
Function Get-ActiveFirewallRules {

    [CmdletBinding()]
    Param (
    )
    $Global:ActiveProfiles = Get-ConnectionProfiles
    $ActiveRules = `
        Get-NetFirewallProfile -Name $Global:ActiveProfiles | Get-NetFirewallRule -PolicyStore ActiveStore | `
        Where-Object { $_.enabled -eq "true" } | `
        Select-Object -Property `
    @{label = "Name" ; expression = { $_.displayname } }, 
    @{label = "Direction" ; expression = { $_.direction } }, 
    @{label = "Profiles" ; expression = { $_.Profile } },
    @{label = "Action" ; expression = { $_.Action } },
    @{Name = 'Protocol'; Expression = { ($PSItem | Get-NetFirewallPortFilter).Protocol } },
    @{Name = 'LocalPort'; Expression = { ($PSItem | Get-NetFirewallPortFilter).LocalPort } },
    @{Name = 'RemotePort'; Expression = { ($PSItem | Get-NetFirewallPortFilter).RemotePort } },
    @{Name = 'RemoteAddress'; Expression = { ($PSItem | Get-NetFirewallAddressFilter).RemoteAddress } }#,
    #@{Name = 'Program'; Expression = { ($PSItem | Get-NetFirewallApplicationFilter).AppPath } }
    return $ActiveRules 
}

# Main Start
Clear-Host
$out = (Get-ActiveFirewallRules) 
$out  | Out-GridView -Title "Total active Windows Firewall rules: $($out.count) / From active profiles: $($Global:ActiveProfiles -join ",")"
