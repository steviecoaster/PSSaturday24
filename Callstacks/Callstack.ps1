Function Get-Main {
    $Index = 0
    $Global:Var = (Get-PSCallStack).Command
    $Var | ForEach-Object {
        "Index $Index : $_"
        $Index ++
    }
}
 
Function Get-OneUpOne {
    Get-Main
}
 
Function Get-OneUpTwo {
    Get-OneUpOne
}
 
Function Get-OneUpThree {
    Get-OneUpTwo
}
 
Function Get-OneUpFour {
    Get-OneUpThree
}
 
Get-OneUpFour