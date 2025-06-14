Set-ExecutionPolicy unrestricted -Scope CurrentUser -Force

$ENV:STARSHIP_CONFIG = "$HOME\config\starship.toml"

Function l() {
	lsd --blocks=permission,user,size,date,name -a -F -l --header
}

Invoke-Expression (&starship init powershell)

atuin init powershell | Out-String | Invoke-Expression

Invoke-Expression (& { (zoxide init powershell | Out-String) })
