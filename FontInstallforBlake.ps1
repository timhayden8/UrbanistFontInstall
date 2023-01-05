invoke-webrequest -uri "https://fonts.google.com/download?family=Urbanist" -outfile $psscriptroot\Urbanist.zip
expand-archive -path $psscriptroot\urbanist.zip -destinationpath $psscriptroot\font
$fonts = get-childitem $psscriptroot\font\static
foreach ($font in $fonts)
{
   copy-item $font.FullName -destination "$($env:windir)\Fonts\ + $font.Name)" -force
   Get-ItemProperty -Name $font.Name -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -ErrorAction SilentlyContinue   
   New-ItemProperty -Name $font.Name -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value $font.Name -Force -ErrorAction SilentlyContinue
}
Remove-item $psscriptroot\font -force
Remove-item $psscriptroot\Urbanist.zip -force
