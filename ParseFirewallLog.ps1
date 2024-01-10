<#
.SYNOPSIS
Parses a Windows Firewall log file and extracts the desired fields.

.DESCRIPTION
The Parse-WindowsFirewallLog function reads a Windows Firewall log file and parses each log entry to extract the desired fields, such as date, time, action, protocol, source IP, destination IP, source port, and destination port. It returns the parsed fields as a custom object.

.PARAMETER LogFilePath
The path to the Windows Firewall log file.

.EXAMPLE
PS C:\> Parse-WindowsFirewallLog -LogFilePath "C:\Logs\Firewall.log"
This example parses the "Firewall.log" file located at "C:\Logs\" and returns the parsed fields.

.INPUTS
None.

.OUTPUTS
System.Management.Automation.PSCustomObject.

#>
function Parse-WindowsFirewallLog {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateScript({ Test-Path $_ -PathType 'Leaf' })]
        [string]$LogFilePath
    )

    # Check if the user is a member of the administrator group
    if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "You must be a member of the administrator group to run this function."
        return
    }

    # Read the log file
    $logContent = Get-Content -Path $LogFilePath

    # Parse each log entry
    foreach ($line in $logContent) {
        # Parse the log entry fields
        $fields = $line -split '\s+'

        # Extract the desired fields
        $date = $fields[0]
        $time = $fields[1]
        $action = $fields[2]
        $protocol = $fields[3]
        $sourceIP = $fields[4]
        $destinationIP = $fields[5]
        $sourcePort = $fields[6]
        $destinationPort = $fields[7]

        # Output the parsed fields
        [PSCustomObject]@{
            Date            = $date
            Time            = $time
            Action          = $action
            Protocol        = $protocol
            SourceIP        = $sourceIP
            DestinationIP   = $destinationIP
            SourcePort      = $sourcePort
            DestinationPort = $destinationPort
        }
    }
}

# BEGIN: Parse-WindowsFirewallLog -Example\
# Parse the Windows Firewall log for Drop actions   
Parse-WindowsFirewallLog -LogFilePath 'C:\Windows\System32\LogFiles\Firewall\pfirewall.log' | Where-Object Action -EQ 'DROP' | Format-Table -AutoSize