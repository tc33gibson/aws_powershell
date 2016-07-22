# The following script is designed to be called from other scripts as means to provide 
# a simple method to authentication to AWS and provide Windows credintials to an internet proxy

<#Place this line at the top of your script
& ((Split-Path $MyInvocation.InvocationName) + "\Invoke_MyAWS_Creds")  #Update the "\" to the file path if not in the same directory
#>

$AWSAccessKey = "Enter Key Here" #Update this - Add Access Key
$AWSSecretKey = "Enter Key Here" #Update this - Add Secret Key
$AWSProfile = "Provide a local profile" #Update this - Set for nonprod or prod later
$AWSRegion = "us-east-1" #Set default region - optional

#Setting up proxy creds, sandbox profile and creds
$browser = New-Object System.Net.WebClient
$browser.Proxy.Credentials =[System.Net.CredentialCache]::DefaultNetworkCredentials 
Set-AWSCredentials -AccessKey $AWSAccessKey -SecretKey $AWSSecretKey -StoreAs $AWSProfile
Initialize-AWSDefaults -ProfileName $AWSProfile -region $AWSRegion