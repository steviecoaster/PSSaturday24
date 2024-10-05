[CmdletBinding()]
Param(
    [Parameter(Mandatory)]
    [PSCredential]
    $BreakGlassAccount,

    [Parameter(Mandatory)]
    [Validateset('None', 'Medium', 'Hardened')]
    $SecurityPosture
)

process {
        $MyInvocation
}