<#
.SYNOPSIS
takes a JSON saved from keeper, and extracts only the records associated with the target client(s)

.DESCRIPTION
Long description

.PARAMETER keeperclient
a client name, or an array of name

.PARAMETER keeperjson
the name of the  JSON extract file from keeper

.EXAMPLE
# The below exampled extract all Alexandergroup records then writes only those to a new json file
get-keeperClient -keeperclient "Alexander Group" -keeperjson C:\working\alexander\keeper.json | Out-File "clientinfo.json"


.NOTES

#>
function get-keeperClient {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(mandatory = $true)]
        [string[]] $keeperclient,
        [Parameter(mandatory = $true)]
        [string] $keeperjson
    )
    
    begin {
        $jsonin = (get-content $keeperjson | out-string | convertfrom-Json).shared_folders

    }
    
    process {
        foreach ($aclient in $keeperclient) {
            foreach ($item in $jsonin) {
                if ($item.folders.folder -like $aclient) {
                    $item
                }
            }
        }
    }
    
    end {
        
    }
}
