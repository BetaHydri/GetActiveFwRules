
<#PSScriptInfo

.VERSION 1.0.4

.GUID bb8486a2-bcab-4969-8282-ce407a8fe5b6

.AUTHOR Jan Tiedemann

.COMPANYNAME Jan Tiedemann

.COPYRIGHT 2021

.TAGS Windows Firewall, Rules, Active Rules, Firewall Profile

.LICENSEURI

.PROJECTURI

.ICONURI

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES


.PRIVATEDATA

#>

<# 

.DESCRIPTION 
 Displays all active Windows Firewall rules that are being applied due to the active profiles 

.INPUTS
Get-ActiveFirewallRules

.OUTPUTS
Displays Name, Direction, Profiles, Action, Protocol, LocalPort, RemotePort, RemoteAdress of active firewall rules

.EXAMPLE
$out = (Get-ActiveFirewallRules) 
$out  | Out-GridView -Title "Total active Windows Firewall rules: $($out.count) / From active profiles: $($Global:ActiveProfiles -join ",")"

.EXAMPLE
Get-ActiveFirewallRules | Format-Table -AutoSize
#> 

[CmdletBinding()]
Param()


#region Helper Functions
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
    return $MyActiveProfiles = $MyActiveProfiles | Select-Object -Unique
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
    return ($($ActiveRules | Sort-Object -Unique Name, Direction, Profiles, Action, Protocol, LocalPort, RemotePort, RemoteAddress))
}
#endregion

