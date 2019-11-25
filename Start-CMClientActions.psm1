<#
.SYNOPSIS
The template gives a good starting point for creating powershell functions and tools.
Start your design with writing out the examples as a functional spesification.
.DESCRIPTION
.PARAMETER
.EXAMPLE
#>

function Start-CMClientActions {
    [CmdletBinding()]
    #^ Optional ..Binding(SupportShouldProcess=$True,ConfirmImpact='Low')
    param (
    [Parameter(Mandatory=$True,
        ValueFromPipeline=$True,
        ValueFromPipelineByPropertyName=$True)]
    [Alias('CN','MachineName','HostName','Name')]
    [string[]]$ComputerName,

    [string[]]$Action = "All"
    )

BEGIN {
    #ScheduleID's for the TriggerSchedule method of SMS_Client
    #Application Deployment Evaluation Cycle
    $ApplicationDeploymentEvaluationCycle = "{00000000-0000-0000-000000000121}"
    
    #Discovery Data Collection
    $DiscoveryDataCollection = "{00000000-0000-0000-000000000003}"

    #File Collection Cycle
    $FileCollectionCycle = "{00000000-0000-0000-000000000010}"

    #Hardware Inventory Cycle
    $HardwareInventoryCycle = "{00000000-0000-0000-000000000001}"

    #Machine Policy Retrieval Cycle
    $MachinePolicyRetrievalCycle = "{00000000-0000-0000-000000000021}"

    #Machine Policy Evaluation Cycle
    $MachinePolicyEvaluationCycle = "{00000000-0000-0000-000000000022}"

    #Software Inventory Cycle
    $SoftwareInventoryCycle = "{00000000-0000-0000-000000000002}"

    #Software Metering Usage Report Cycle
    $SoftwareMeteringUsageReportCycle = "{00000000-0000-0000-000000000031}"

    #Software Update Deployment Evaluation Cycle
    $SoftwareUpdateDeploymentEvaluationCycle = "{00000000-0000-0000-000000000114}"

    #Software Update Scan Cycle
    $SoftwareUpdateScanCycle = "{00000000-0000-0000-000000000113}"

    #State Message Refresh
    $StateMessageRefresh = "{00000000-0000-0000-000000000111}"

    #User Policy Retrieval Cycle
    $UserPolicyRetrievalCycle = "{00000000-0000-0000-000000000026}"

    #User Policy Evaluation Cycle
    $UserPolicyEvaluationCycle = "{00000000-0000-0000-000000000027}"

    #Windows Installers Source List Update Cycle
    $WindowsInstallersSourceListUpdateCycle = "{00000000-0000-0000-000000000032}"

    $All = @($ApplicationDeploymentEvaluationCycle,
                $DiscoveryDataCollection,
                $FileCollectionCycle,
                $HardwareInventoryCycle,
                $MachinePolicyRetrievalCycle,
                $MachinePolicyEvaluationCycle,
                $SoftwareInventoryCycle,
                $SoftwareMeteringUsageReportCycle,
                $SoftwareUpdateDeploymentEvaluationCycle,
                $SoftwareUpdateScanCycle,
                $StateMessageRefresh,
                $UserPolicyRetrievalCycle,
                $UserPolicyEvaluationCycle,
                $WindowsInstallersSourceListUpdateCycle)
}

PROCESS {
    foreach($computer in $ComputerName){
        if($Action -eq "All" -or $Action -eq "all"){
            foreach($ScheduleID in $All){
                Invoke-WmiMethod -ComputerName $computer -Namespace root\ccm -Class SMS_Client -Name TriggerSchedule $ScheduleID
            }
        }
    } #foreach
}


END {
    # Intentionaly left empty.
    # This block is used to provide one-time post-processing for the function.
}

} #Function