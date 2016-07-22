$AWSAccessKey = "Enter Key Here" #Update this - Add Access Key
$AWSSecretKey = "Enter Key Here" #Update this - Add Secret Key
$AWSProfile = "Provide a local profile" #Update this - Set for nonprod or prod later
$AWSRegion = "us-east-1" #Set default region - optional

#Setting up proxy creds, sandbox profile and creds
$browser = New-Object System.Net.WebClient
$browser.Proxy.Credentials =[System.Net.CredentialCache]::DefaultNetworkCredentials 
Set-AWSCredentials -AccessKey $AWSAccessKey -SecretKey $AWSSecretKey -StoreAs $AWSProfile
Initialize-AWSDefaults -ProfileName $AWSProfile -region $AWSRegion