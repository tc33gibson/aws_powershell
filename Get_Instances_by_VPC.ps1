#Setting up proxy and Intializing AWS creds
& ((Split-Path $MyInvocation.InvocationName) + "\Invoke_MyAWS_Creds")  #Update this or comment out; This invokes creds for AWS and proxy

$Instances = (Get-EC2Instance).instances
$AWSVPC = "Enter VPC ID here" #Update this
$VPCName = "Enter VPC Name" #Update this
$VPCS = (Get-EC2Vpc)| Select | ? {$_.Tag.Key -eq "Name" -and $_.Tag.Value -eq "$VPCName"}
$vms = foreach ($VPC in $VPCS) {
     $Instances | Where-Object {$_.VpcId -eq $AWSVPC} | foreach {
        New-Object -TypeName PSObject -Property @{
            'VpcId' = $_.VpcId
            'VPCName' = ($VPC.Tags | Where-Object {$_.Key -eq 'Name'}).Value
            'InstanceId' = $_.InstanceId
            'ADName' = ($_.Tags | Where-Object {$_.Key -eq 'ADname'}).Value
            'InstanceType' = $_.InstanceType
            "PrivateIP" = $_.PrivateIpAddress
            "SubnetID" = $_.SubnetId
            "ImageID" = $_.ImageId
            'MyName' = ($_.Tags | Where-Object {$_.Key -eq 'lm:name'}).Value #Update this or comment out; pulls custom tags; add more as needed
			'MyDept' = ($_.Tags | Where-Object {$_.Key -eq 'lm:name'}).Value #Update this or comment out; pulls custom tags; add more as needed
            'LaunchTime' = $_.LaunchTime
            'State' = $_.State.Name
            'KeyName' = $_.KeyName
            'Platform' = $_.Platform
          
        }
    }
}

$vms | out-gridview 


