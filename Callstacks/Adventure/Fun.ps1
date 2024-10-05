function Get-Direction {
    [CmdletBinding()]
    Param(
        [Parameter()]
        [Validateset('left','right','up','down')]
        [string]
        $Direction
    )

    Write-host "You picked: $Direction"
    Get-PSCallStack | Select-Object * | Select -First 1
}

function ConvertTo-CommandArguments {
    param (
        [string]$ExecutedCommand
    )

    # Define the regex pattern with named capture groups
    $pattern = '(?<Command>\S+)\s*(?<Arguments>.*)'

    # Initialize the result object
    $result = [PSCustomObject]@{
        Command   = $null
        Arguments = @{}
    }

    # Perform the match
    if ($ExecutedCommand -match $pattern) {
        # Capture the named groups
        $result.Command = $matches['Command']
        $argumentsString = $matches['Arguments']

        # Split the arguments into an array
        $argsArray = $argumentsString -split '\s+'

        # Process the arguments
        for ($i = 0; $i -lt $argsArray.Count; $i++) {
            if ($argsArray[$i] -like '-*') {
                # Treat the next item as the value for the current key
                if ($i + 1 -lt $argsArray.Count -and $argsArray[$i + 1] -notlike '-*') {
                    $key = $argsArray[$i]
                    $value = $argsArray[$i + 1]
                    $result.Arguments[$key] = $value
                    $i++ # Skip the next item as it's already used
                }
                else {
                    # Handle cases where there is no value (e.g., flags)
                    $result.Arguments[$argsArray[$i]] = $null
                }
            }
        }
    }

    return $result
}

Get-Direction -Direction left