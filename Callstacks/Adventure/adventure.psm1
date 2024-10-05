function Invoke-Attack {
    param (
        [hashtable]$gameState,
        [int]$damage
    )
    
    $gameState.EnemyHealth -= $damage
    $callstack = Get-PSCallStack
    Show-TurnInfo -CallStack $callstack -gameState $gameState
}

function Invoke-Defend {
    param (
        [hashtable]$gameState,
        [int]$defensePoints
    )
    if (-not ($gameState.PlayerHealth + $defensePoints) -gt 100) {
        $gameState.PlayerHealth += $defensePoints
    }

    $callstack = Get-PSCallStack
    Show-TurnInfo -CallStack $callstack -gameState $gameState
}

function Get-EnemyAttack {
    param (
        [hashtable]$gameState
    )

    $damage = Get-Random -Minimum 5 -Maximum 20
    Write-Host "Enemy counters, causing $damage damage! The rat bastard!" -ForegroundColor DarkYellow
    $gameState.PlayerHealth -= $damage
}

function Show-TurnInfo {
    [CmdletBinding()]
    Param(
        [Parameter()]
        [PSObject]
        $CallStack,

        [Parameter()]
        [hashtable]
        $gameState
    )

    end {
        
        switch ($CallStack.Command) {
            'Invoke-Attack' {
                Write-Host "You attacked the enemy for $damage damage!" -ForegroundColor DarkRed
            }

            'Invoke-Defend' {
                Write-Host "You defended and gained $defensePoints health!" -ForegroundColor DarkCyan
            }
        }
    }
}

function Start-Adventure {
    # Initialize game state
    $gameState = @{
        PlayerHealth = 100
        EnemyHealth  = 100
    }

    # Game Loop
    while ($gameState.PlayerHealth -gt 0 -and $gameState.EnemyHealth -gt 0) {
        Show-GameStatus -gameState $gameState
        Write-Host "Choose an action: (1) Attack (2) Defend"
        $choice = Read-Host "Enter your choice"
        
        switch ($choice) {
            1 { Invoke-Attack -gameState $gameState -damage (Get-Random -Minimum 10 -Maximum 20) }
            2 { Invoke-Defend -gameState $gameState -defensePoints (Get-Random -Minimum 5 -Maximum 15) }
            default { Write-Host "Invalid choice. Please choose again." }
        }
        
        Show-TurnInfo
        # Enemy attacks after player's turn
        Get-EnemyAttack -gameState $gameState
    }

    if ($gameState.PlayerHealth -le 0) {
        Write-Host "You have been defeated by the enemy."
    }
    elseif ($gameState.EnemyHealth -le 0) {
        Write-Host "You have defeated the enemy!"
    }
}

function Show-GameStatus {
    param (
        [hashtable]$gameState
    )
    Write-Host "Player Health: $($gameState.PlayerHealth)"
    Write-Host "Enemy Health: $($gameState.EnemyHealth)"

}
