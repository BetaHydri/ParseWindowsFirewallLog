# Parse-WindowsFirewallLog Function

The `Parse-WindowsFirewallLog` is a PowerShell function designed to parse a Windows Firewall log file and extract the desired fields. 

## Description

This function reads a Windows Firewall log file and parses each log entry to extract the desired fields, such as date, time, action, protocol, source IP, destination IP, source port, and destination port. It returns the parsed fields as a custom object.

## Parameters

- `LogFilePath`: The path to the Windows Firewall log file. This is a mandatory parameter.

## Usage

```powershell
PS C:\> Parse-WindowsFirewallLog -LogFilePath "C:\Logs\Firewall.log"
```

In the above example, the function parses the "Firewall.log" file located at "C:\Logs\" and returns the parsed fields.

## Inputs

This function does not accept any inputs.

## Outputs

This function returns a `System.Management.Automation.PSCustomObject`.

## Prerequisites

The user must be a member of the administrator group to use this function. If the user is not an administrator, the function will not execute.

## Note

This function uses the `Test-Path` cmdlet to validate the `LogFilePath` parameter. If the provided path does not exist or is not a file, the function will throw an error.