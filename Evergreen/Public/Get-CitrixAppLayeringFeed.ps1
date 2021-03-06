Function Get-CitrixAppLayeringFeed {
    <#
        .SYNOPSIS
            Gets the current available Citrix App Layering release versions.

        .DESCRIPTION
            Reads the public Citrix App Layering web page to return an array of App Layering platforms and the available versions.

        .NOTES
            Author: Aaron Parker
            Twitter: @stealthpuppy
        
        .EXAMPLE
            Get-CitrixAppLayeringFeed

            Description:
            Returns the available Citrix App Layering versions for all platforms.
    #>
    [OutputType([System.Management.Automation.PSObject])]
    [CmdletBinding()]
    Param()

    # Get application resource strings from its manifest
    $res = Get-FunctionResource -AppName "CitrixFeeds"
    Write-Verbose -Message $res.Name

    # Read the feed and filter for include and exclude strings and return output to the pipeline
    $gcfParams = @{
        Uri     = $res.Get.AppLayering.Uri
        Include = $res.Get.AppLayering.Include
        Exclude = $res.Get.AppLayering.Exclude
    }
    $Content = Get-CitrixRssFeed @gcfParams
    If ($Null -ne $Content) {
        Write-Output -InputObject $Content
    }
}
