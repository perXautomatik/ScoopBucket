# accept arbitary json of nest depth > 1 
# returns each key valuepair at depth 1
## as a separate flat list
## each returned value is json
#

function unnest{

param (  
  [Parameter(ValueFromPipeline = $true)]
  [string]$input
)

    $json = ($input | ConvertFrom-Json )
    if (($json | Measure-Object).count -eq 0)
    {
        return "malformed json, failed at ConvertFrom-json"
    }
    else
    {
    $psObjectWithTypeHeader = $json.psobject.properties.value

        if (($psObjectWithTypeHeader | Measure-Object).count -eq 0)
        {
            return "malformed json, failed at psobject.properties.value"
        }
        else
        {
            $psObjectProperies = $psObjectWithTypeHeader.PSObject.Properties
        #
            if (($psObjectProperies | Measure-Object).count -eq 0)
            {
                return "malformed json, failed at psobject.properties"
            }
            else
            {

                $flatListContentExposedStillToNested = $psObjectProperies | ForEach-Object { $_.Name; $_.Value }     
                #
                if (($flatListContentExposedStillToNested | Measure-Object).count -eq 0)
                {
                    $nothing = $psObjectWithTypeHeader | Get-Member -MemberType Property | ForEach-Object {$_.Name} #suggestedAlternative
                    #
                    if (($nothing | Measure-Object).count -eq 0)
                    {
                        return "malformed json, failed at get-member-membertype"
                    }
                    else
                    {
                        $flatListContentExposedStillToNested = $nothing
                    }
                
                }
                else
                {
                    #
                    if (($flatListContentExposedStillToNested | Measure-Object).count -eq 0)
                    {
                        return "malformed json, failed at for-EachObject"
                    }
                    else
                    {

                        $flatListContentExposedStillToNested | ForEach-Object { $_ | ConvertTo-Json }     

                    }
                    #   

                }
                #
            }
        #
        }

    }

}