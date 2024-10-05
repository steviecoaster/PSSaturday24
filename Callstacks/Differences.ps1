#region Start
function Test-CallStack {
    Write-Host 'This shows what a callstack gives you'
    Get-PSCallStack | Select-Object *
}

function Test-Invocation {
    Write-Host 'This shows what invocation gives you'
    $MyInvocation | Select-Object *
}
#endregion

#region First
function Show-Callstack {
    Get-PSCallStack | Select-Object *
}

function Get-Level {

    Write-Host "I'm first!"
    Get-Something
}

function Get-Something {
    Write-Host "I get called second"
    Show-Callstack
}

Get-Level
#endregion

#region Second
function Get-Something {
    Write-Host "I get called second"
    $MyInvocation
}
function Get-Level {

    Write-Host "I'm first!"
    Get-Something
}

Get-Level
#endregion