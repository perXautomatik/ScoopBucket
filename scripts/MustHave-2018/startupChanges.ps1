
function Change-Language { param ($Language) ; Set-ItemProperty 'HKCU:\Control Panel\Desktop' -Name "PreferredUILanguages" -Value $Language } ; Change-Language -language 'en-us'